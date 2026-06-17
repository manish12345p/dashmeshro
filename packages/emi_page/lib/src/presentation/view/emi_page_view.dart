import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:core/core.dart';
import '../../domain/entities/emi_dashboard_data.dart';
import '../../domain/use_cases/get_emi_dashboard_data_usecase.dart';
import '../../domain/use_cases/mark_emi_paid_usecase.dart';
import '../../domain/use_cases/add_emi_payment_usecase.dart';
import '../bloc/emi_bloc.dart';
import '../bloc/emi_event.dart';
import '../bloc/emi_state.dart';
import 'package:core_ui/core_ui.dart';
import '../widgets/active_installments_list.dart';
import '../widgets/emi_header.dart';
// import '../widgets/pending_month_card.dart';

class EmiPageView extends StatelessWidget {
  const EmiPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the Bloc at the top level of this page
    return BlocProvider(
      create: (context) => EmiBloc(
        sl<GetEmiDashboardDataUseCase>(),
        sl<MarkEmiPaidUseCase>(),
        sl<AddEmiPaymentUseCase>(),
      )..add(const LoadDashboard()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.colors.background,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            AppStrings.emiAppTitle,
            style: TextStyle(
              color: context.colors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            // Removed person icon as requested
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<EmiBloc, EmiState>(
            builder: (context, state) {
              if (state.status == EmiStatus.initial ||
                  state.status == EmiStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == EmiStatus.failure) {
                return Center(
                  child: Text(
                    '${AppStrings.genericError}: ${state.errorMessage}',
                  ),
                );
              }

              final data = state.data;
              if (data == null) {
                return const Center(child: Text(AppStrings.noDataFound));
              }

              final today = DateTime.now();
              // Filter active installments based on selected filter
              final filteredInstallments = data.activeInstallments.where((inst) {
                // 1. Search Logic
                if (state.searchQuery.isNotEmpty) {
                  final q = state.searchQuery.toLowerCase();
                  if (!inst.customerName.toLowerCase().contains(q) &&
                      !inst.vehicleDetails.toLowerCase().contains(q) &&
                      !inst.serviceName.toLowerCase().contains(q)) {
                    return false;
                  }
                }

                // 2. Filter Logic
                if (state.selectedFilter == 'All') return true;
                if (state.selectedFilter == 'Overdue') return inst.status == 'overdue';
                if (state.selectedFilter == 'Pending') return inst.status == 'pending';
                if (state.selectedFilter == 'Paid') {
                  if (inst.status == 'paid_this_month' || inst.status == 'paid') return true;
                  try {
                    if (inst.lastPaymentDateStr.isNotEmpty) {
                      final pd = DateTime.parse(inst.lastPaymentDateStr);
                      return pd.month == today.month && pd.year == today.year;
                    }
                  } catch (_) {}
                  return false;
                }
                return true;
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EmiHeader(),
                    // const SizedBox(height: 8),
                    // PendingMonthCard(
                    //   pendingAmount: data.pendingThisMonth,
                    //   clientsCount: data.pendingClientsCount,
                    //   collectionPercentage:
                    //       data.monthlyTargetCollectionPercentage,
                    // ),
                    // const SizedBox(height: 16),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   child: Text(
                    //     '${AppStrings.totalPaidThisMonth}: ₹${data.collectedThisMonth.toStringAsFixed(0)}',
                    //     style: TextStyle(
                    //       color: context.colors.primary,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          final q = textEditingValue.text.toLowerCase();
                          return data.activeInstallments
                              .map((e) => e.customerName)
                              .where((name) => name.toLowerCase().contains(q))
                              .toSet();
                        },
                        onSelected: (String selection) {
                          context.read<EmiBloc>().add(SearchInstallments(selection));
                        },
                        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                          return TextField(
                            controller: controller,
                            focusNode: focusNode,
                            onChanged: (val) {
                              context.read<EmiBloc>().add(SearchInstallments(val));
                            },
                            decoration: InputDecoration(
                              hintText: AppStrings.searchPendingOrOverdue,
                              prefixIcon: Icon(
                                Icons.search,
                                color: context.colors.textSecondary,
                              ),
                              filled: true,
                              fillColor: context.colors.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: context.colors.border,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: context.colors.border,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: context.colors.primary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    ActiveInstallmentsList(
                      installments: filteredInstallments,
                      selectedFilter: state.selectedFilter,
                      onFilterChanged: (filter) {
                        context.read<EmiBloc>().add(FilterInstallments(filter));
                      },
                      onRemind: (id) {
                        context.read<EmiBloc>().add(RemindCustomer(id));
                      },
                      onMarkPaid: (id) {
                        context.read<EmiBloc>().add(MarkAsPaid(id));
                      },
                      onAddPayment: (id, amount) {
                        context.read<EmiBloc>().add(AddPayment(id, amount));
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildCustomerNamesList(
                      context: context,
                      title: AppStrings.overdueCustomers,
                      installments: data.activeInstallments.where((i) {
                        return i.status == 'overdue';
                      }).toList(),
                      color: context.colors.error,
                    ),
                    const SizedBox(height: 16),
                    _buildCustomerNamesList(
                      context: context,
                      title: AppStrings.pendingCustomers,
                      installments: data.activeInstallments.where((i) {
                        if (i.status != 'pending') return false;
                        try {
                          if (i.dueDate.isNotEmpty) {
                            final dd = DateTime.parse(i.dueDate);
                            final today = DateTime.now();
                            return dd.month == today.month &&
                                dd.year == today.year;
                          }
                        } catch (_) {}
                        return false;
                      }).toList(),
                      color: context.colors.warning,
                    ),
                    const SizedBox(
                      height: 120,
                    ), // Extra space to scroll past the bottom navbar
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerNamesList({
    required BuildContext context,
    required String title,
    required List<ActiveInstallment> installments,
    required Color color,
  }) {
    final seen = <String>{};
    final uniqueInstallments = installments
        .where((inst) => seen.add(inst.customerName))
        .toList();

    if (uniqueInstallments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: context.colors.textTertiary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.none,
              style: TextStyle(
                color: context.colors.textTertiary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    final displayInstallments = uniqueInstallments.take(5).toList();
    final hasMore = uniqueInstallments.length > 5;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: context.colors.textTertiary,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...displayInstallments.asMap().entries.map((entry) {
                final index = entry.key;
                final installment = entry.value;
                final isLast = index == displayInstallments.length - 1;

                return InkWell(
                  onTap: () {
                    if (installment.customerId.isNotEmpty) {
                      context.push('/customers/${installment.customerId}');
                    }
                  },
                  child: Text(
                    '${installment.customerName}${isLast && !hasMore ? '' : ','}',
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: installment.customerId.isNotEmpty
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                );
              }),
              if (hasMore)
                Text(
                  '.......',
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
