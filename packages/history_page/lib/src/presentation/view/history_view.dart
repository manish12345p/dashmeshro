import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:core/core.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/history_item.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';
import '../widgets/history_service_card.dart';

class HistoryView extends StatelessWidget {
  final HistoryBloc? bloc;

  const HistoryView({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    return bloc != null 
      ? BlocProvider.value(
          value: bloc!,
          child: _HistoryScaffold(),
        )
      : BlocProvider(
          create: (context) => sl<HistoryBloc>()..add(const HistoryEvent.loadHistory()),
          child: _HistoryScaffold(),
        );
  }
}

class _HistoryScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: context.colors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppPadding.p12),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: context.colors.textPrimary,
                        ),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/');
                          }
                        },
                      ),
                      const SizedBox(width: AppPadding.p4),
                      Text(
                        'Dashmesh Mechanix',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: context.colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppPadding.p16),
                  Text(
                    'Service\nHistory',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: context.colors.primaryDark,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: AppPadding.p24),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusMedium,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.textSecondary.withValues(
                            alpha: 0.05,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: BlocBuilder<HistoryBloc, HistoryState>(
                      buildWhen: (previous, current) =>
                          previous.searchQuery != current.searchQuery,
                      builder: (context, state) {
                        return TextField(
                          onChanged: (value) => context
                              .read<HistoryBloc>()
                              .add(HistoryEvent.searchQueryChanged(value)),
                          decoration: InputDecoration(
                            hintText: 'Search by name or address...',
                            hintStyle: TextStyle(
                              color: context.colors.textQuaternary,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: context.colors.textTertiary,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppPadding.p16),

                  // Service Type Filters
                  BlocBuilder<HistoryBloc, HistoryState>(
                    buildWhen: (previous, current) =>
                        previous.selectedServiceType !=
                            current.selectedServiceType ||
                        previous.allServices.length !=
                            current.allServices.length,
                    builder: (context, state) {
                      // Extract unique service types
                      final types = {'All'};
                      for (var item in state.allServices) {
                        if (item.serviceType.isNotEmpty) {
                          types.add(item.serviceType.trim());
                        }
                      }
                      final typeList = types.toList()..sort();

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: typeList.map((type) {
                            final isSelected = state.selectedServiceType == type;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(type),
                                selected: isSelected,
                                onSelected: (selected) {
                                  if (selected) {
                                    context.read<HistoryBloc>().add(
                                          HistoryEvent.filterByServiceType(type),
                                        );
                                  } else {
                                    context.read<HistoryBloc>().add(
                                          const HistoryEvent.filterByServiceType('All'),
                                        );
                                  }
                                },
                                backgroundColor: context.colors.surface,
                                selectedColor:
                                    context.colors.primary.withValues(alpha: 0.1),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? context.colors.primary
                                      : context.colors.textSecondary,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: isSelected
                                        ? context.colors.primary
                                        : context.colors.border,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppPadding.p8),
                ],
              ),
            ),

            // Content Section
            Expanded(
              child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state.isLoading && state.allServices.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.errorMessage != null && state.allServices.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: context.colors.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.errorMessage!,
                            style: TextStyle(color: context.colors.error),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  // Apply filters
                  var filteredServices = state.allServices;

                  // Text Search
                  if (state.searchQuery.isNotEmpty) {
                    final query = state.searchQuery.toLowerCase();
                    filteredServices = filteredServices.where((item) {
                      final dateStr = DateFormat('dd/MM/yyyy').format(item.serviceDate).toLowerCase();
                      final dateStr2 = DateFormat('MMM dd, yyyy').format(item.serviceDate).toLowerCase();
                      
                      return item.customerName.toLowerCase().contains(query) ||
                          item.customerAddress.toLowerCase().contains(query) ||
                          item.customerPhone.toLowerCase().contains(query) ||
                          item.serviceType.toLowerCase().contains(query) ||
                          item.note.toLowerCase().contains(query) ||
                          item.fault.toLowerCase().contains(query) ||
                          item.status.toLowerCase().contains(query) ||
                          item.totalAmount.toString().contains(query) ||
                          item.amountPaid.toString().contains(query) ||
                          item.amountPending.toString().contains(query) ||
                          item.serviceDuration.toLowerCase().contains(query) ||
                          item.guaranteeDuration.toLowerCase().contains(query) ||
                          item.customerId.toLowerCase().contains(query) ||
                          dateStr.contains(query) ||
                          dateStr2.contains(query);
                    }).toList();
                  }

                  // Type Filter
                  if (state.selectedServiceType != 'All') {
                    filteredServices = filteredServices.where((item) {
                      return item.serviceType.trim().toLowerCase() ==
                          state.selectedServiceType.toLowerCase();
                    }).toList();
                  }

                  if (filteredServices.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 48,
                            color: context.colors.textTertiary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No service history found.',
                            style: TextStyle(
                              color: context.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Group by date
                  final groupedServices = <String, List<HistoryItem>>{};
                  final dateFormat = DateFormat('MMM dd, yyyy');

                  for (var item in filteredServices) {
                    // Create date without time to ensure proper grouping
                    final dateKey = DateTime(
                      item.serviceDate.year,
                      item.serviceDate.month,
                      item.serviceDate.day,
                    ).toIso8601String();

                    groupedServices.putIfAbsent(dateKey, () => []).add(item);
                  }

                  // Sort dates descending
                  final sortedDates = groupedServices.keys.toList()
                    ..sort((a, b) => b.compareTo(a));

                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<HistoryBloc>()
                          .add(const HistoryEvent.loadHistory());
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p16,
                        right: AppPadding.p16,
                        bottom: 100,
                      ),
                      itemCount: sortedDates.length,
                      itemBuilder: (context, index) {
                        final dateStr = sortedDates[index];
                        final date = DateTime.parse(dateStr);
                        final items = groupedServices[dateStr]!;
                        final displayDate = dateFormat.format(date);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(
                              title: displayDate,
                              subtitle: '${items.length} service(s)',
                            ),
                            const SizedBox(height: 12),
                            ...items.map(
                              (item) => HistoryServiceCard(
                                item: item,
                                onTap: () {
                                  // Navigate to customer details
                                  if (item.customerId.isNotEmpty) {
                                    context.push('/customers/${item.customerId}');
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
