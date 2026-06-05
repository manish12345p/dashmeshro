import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:core_ui/core_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/customer_repository_interface.dart';
import '../../data/repositories/customer_repository.dart';
import '../../domain/use_cases/get_customer_by_id_usecase.dart';
import '../bloc/customer_details_bloc.dart';
import '../bloc/customer_details_event.dart';
import '../bloc/customer_details_state.dart';
import '../../domain/entities/customer.dart';
import '../widgets/profile_header_card.dart';
import 'package:core/core.dart'; // import app_role

import '../widgets/stats_grid.dart';
import '../widgets/activity_card.dart';

class CustomerDetailsView extends StatelessWidget {
  final String customerId;
  final CustomerDetailsBloc? bloc;
  final ICustomerRepository? repository;

  const CustomerDetailsView({
    super.key,
    required this.customerId,
    this.bloc,
    this.repository,
  });

  @override
  Widget build(BuildContext context) {
    final repo = repository ?? GetIt.instance<ICustomerRepository>();

    return BlocProvider(
      create: (context) =>
          bloc ??
                CustomerDetailsBloc(
                  getCustomerByIdUseCase: GetCustomerByIdUseCase(repo),
                )
            ..add(LoadCustomerDetails(customerId)),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            'Dashmesh Mechanix',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 1.1,
            ),
          ),
        ),
        body: const _CustomerDetailsContent(),
      ),
    );
  }
}

class _CustomerDetailsContent extends StatelessWidget {
  const _CustomerDetailsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
      builder: (context, state) {
        if (state is CustomerDetailsLoading ||
            state is CustomerDetailsInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CustomerDetailsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is CustomerDetailsLoaded) {
          final customer = state.customer;
          return SingleChildScrollView(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header Card
                ProfileHeaderCard(customer: customer),
                SizedBox(height: AppPadding.p16),

                // Schedule service button
                _buildScheduleServiceButton(context, customer),
                SizedBox(height: AppPadding.p16),

                // Pending Amount Card
                _PendingAmountCard(customer: customer),
                SizedBox(height: AppPadding.p16),

                // Stats Grid
                StatsGrid(customer: customer),
                SizedBox(height: AppPadding.p24),

                // Service History
                _ServiceHistorySection(customer: customer),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildScheduleServiceButton(BuildContext context, Customer customer) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.push(
            '/service',
            extra: {
              'customerId': customer.id,
              'customerName': customer.name,
              'showBackButton': true,
            },
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month, color: context.colors.primaryDark),
              SizedBox(width: 8),
              Text(
                'Schedule New Service',
                style: TextStyle(
                  color: context.colors.primaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceHistorySection extends StatefulWidget {
  final Customer customer;

  const _ServiceHistorySection({required this.customer});

  @override
  State<_ServiceHistorySection> createState() => _ServiceHistorySectionState();
}

class _ServiceHistorySectionState extends State<_ServiceHistorySection> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Set Change',
    'AMC',
    'New RO',
    'Repair',
    'Service',
    'Pump',
    'Set Pump',
    'New RO Set Change',
    'Set SV',
    'Install and Set Change',
    'Set & Pump',
    'Inline',
    'Copper Set',
    'Alkaline',
    'Alkaline Set',
    'Set SMPS',
    'Not Applicable',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredHistory = widget.customer.serviceHistory.where((activity) {
      if (_selectedFilter == 'All') return true;
      return activity.serviceType.toLowerCase() ==
          _selectedFilter.toLowerCase();
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Service History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            // Filter Dropdown
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.border),
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  borderRadius: BorderRadius.circular(20),
                  icon: Icon(
                    Icons.filter_list,
                    size: 16,
                    color: context.colors.primaryDark,
                  ),
                  isDense: true,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedFilter = newValue;
                      });
                    }
                  },
                  items: _filters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        if (filteredHistory.isEmpty)
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(
              child: Text(
                'No service records found for this filter.',
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),
          )
        else
          ...filteredHistory.map(
            (activity) => ActivityCard(activity: activity),
          ),
        SizedBox(height: 80), // Margin below service history
      ],
    );
  }
}

class _PendingAmountCard extends StatelessWidget {
  final Customer customer;

  const _PendingAmountCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('installments')
          .where('customer_name', isEqualTo: customer.name)
          .where('status', whereIn: ['pending', 'overdue'])
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox.shrink();

        final docs = snapshot.data!.docs;
        if (docs.isEmpty) return SizedBox.shrink();

        double totalPending = 0;
        for (var doc in docs) {
          totalPending += (doc.data() as Map<String, dynamic>)['amount'] ?? 0.0;
        }

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.errorBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.error),
          ),
          child: InkWell(
            onTap: () async {
              await _showEmiDialog(
                context,
                context.read<CustomerDetailsBloc>(),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Pending Amount',
                      style: TextStyle(
                        color: context.colors.error,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹${totalPending.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: context.colors.error,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: context.colors.error,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showEmiDialog(
    BuildContext context,
    CustomerDetailsBloc bloc,
  ) async {
    // Check if there are any EMIs first
    final snapshot = await FirebaseFirestore.instance
        .collection('installments')
        .where('customer_name', isEqualTo: customer.name)
        .where('status', whereIn: ['pending', 'overdue'])
        .get();

    if (!context.mounted) return;

    if (snapshot.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No pending EMIs left for this customer.'),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('installments')
              .where('customer_name', isEqualTo: customer.name)
              .where('status', whereIn: ['pending', 'overdue'])
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              );
            final docs = snapshot.data!.docs;

            if (docs.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted && Navigator.canPop(context)) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All EMIs cleared!')),
                  );
                }
              });
              return SizedBox.shrink();
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pending EMIs',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16),
                    ...docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final dateStr =
                          data['due_date']?.toString().split('T').first ??
                          'N/A';
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.colors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: context.colors.border),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Due: $dateStr',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: context.colors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Status: ${data['status']}',
                                    style: TextStyle(
                                      color: context.colors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (data['total_amount'] != null) ...[
                                    SizedBox(height: 4),
                                    Text(
                                      'Total: ₹${data['total_amount']}',
                                      style: TextStyle(
                                        color: context.colors.textSecondary,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '₹${data['amount']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.colors.error,
                                  ),
                                ),
                                SizedBox(width: 12),
                                if (context.read<RoleCubit>().state == AppRole.admin)
                                  InkWell(
                                    onTap: () {
                                      _showPartialPaymentDialog(
                                        context,
                                        bloc,
                                        doc,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: context.colors.success,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Pay',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _processPayment(
    BuildContext context,
    CustomerDetailsBloc bloc,
    QueryDocumentSnapshot doc,
    double emiAmount,
    double paidAmount,
    Map<String, dynamic> data,
  ) async {
    try {
      final totalAmount =
          (data['total_amount'] as num?)?.toDouble() ??
          (data['amount'] as num?)?.toDouble() ??
          0.0;
      final newTotalAmount = totalAmount - paidAmount;

      if (newTotalAmount <= 0) {
        await FirebaseFirestore.instance
            .collection('installments')
            .doc(doc.id)
            .update({
              'status': 'paid',
              'paid_at': DateTime.now().toIso8601String(),
              'total_amount': 0.0,
              'amount': 0.0,
            });
      } else {
        DateTime currentDueDate = DateTime.now();
        if (data['due_date'] != null) {
          currentDueDate = DateTime.parse(data['due_date']);
        }
        await FirebaseFirestore.instance
            .collection('installments')
            .doc(doc.id)
            .update({
              'total_amount': newTotalAmount,
              'amount': newTotalAmount < emiAmount ? newTotalAmount : emiAmount,
              'due_date': currentDueDate
                  .add(const Duration(days: 30))
                  .toIso8601String(),
              'last_payment_date': DateTime.now().toIso8601String(),
              'status': 'pending',
            });
      }

      final serviceId = data['service_id'];
      if (serviceId != null) {
        await FirebaseFirestore.instance
            .collection('Customer')
            .doc(customer.id)
            .collection('services')
            .doc(serviceId)
            .update({
              'amountPaid': FieldValue.increment(paidAmount),
              'amountPending': FieldValue.increment(-paidAmount),
            });
      }

      if (paidAmount > 0) {
        try {
          await FirebaseFirestore.instance.collection('payments').add({
            'customer_id': customer.id,
            'amount': paidAmount,
            'source': 'emi_payment',
            'reference_id': doc.id,
            'date': DateTime.now().toIso8601String(),
          });
        } catch (_) {}
      }

      bloc.add(LoadCustomerDetails(customer.id));
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Payment recorded')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _showPartialPaymentDialog(
    BuildContext context,
    CustomerDetailsBloc bloc,
    QueryDocumentSnapshot doc,
  ) {
    final data = doc.data() as Map<String, dynamic>;
    final emiAmount = (data['amount'] as num).toDouble();
    final controller = TextEditingController(
      text: emiAmount.toStringAsFixed(0),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Pay EMI'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount to Pay',
            prefixText: '₹ ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [context.colors.primaryDark, context.colors.primary],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () async {
                final paidAmount = double.tryParse(controller.text) ?? 0.0;
                if (paidAmount <= 0) return;

                if (paidAmount < emiAmount) {
                  showDialog(
                    context: dialogContext,
                    builder: (confirmCtx) => AlertDialog(
                      title: Text('Confirm Partial Payment'),
                      content: Text(
                        'The EMI amount is ₹${emiAmount.toStringAsFixed(0)}, but you entered ₹${paidAmount.toStringAsFixed(0)}. Are you sure you want to pay less?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(confirmCtx),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(confirmCtx);
                            Navigator.pop(dialogContext);
                            _processPayment(
                              context,
                              bloc,
                              doc,
                              emiAmount,
                              paidAmount,
                              data,
                            );
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.pop(dialogContext);
                  _processPayment(
                    context,
                    bloc,
                    doc,
                    emiAmount,
                    paidAmount,
                    data,
                  );
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
