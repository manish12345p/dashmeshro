import 'package:flutter/material.dart';
import '../../domain/entities/emi_dashboard_data.dart';
import 'package:core_ui/core_ui.dart';
import 'installment_list_item.dart';

class ActiveInstallmentsList extends StatelessWidget {
  final List<ActiveInstallment> installments;
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final Function(String) onRemind;
  final Function(String) onMarkPaid;
  final Function(String, double) onAddPayment;

  const ActiveInstallmentsList({
    super.key,
    required this.installments,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onRemind,
    required this.onMarkPaid,
    required this.onAddPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Active Installments',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.textSecondary.withValues(
                        alpha: 0.02,
                      ),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(context, 'All'),
                      _buildFilterChip(context, 'Pending'),
                      _buildFilterChip(context, 'Overdue'),
                      _buildFilterChip(context, 'Rent'),
                      _buildFilterChip(context, 'Paid'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (installments.isEmpty && selectedFilter == 'Overdue')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: context.colors.success,
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No overdue payments 🎉',
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...installments.map((installment) {
              return InstallmentListItem(
                installment: installment,
                onRemind: () => onRemind(installment.id),
                onMarkPaid: () => onMarkPaid(installment.id),
                onAddPayment: (amount) => onAddPayment(installment.id, amount),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => onFilterChanged(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? context.colors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.colors.textSecondary.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? context.colors.textPrimary
                : context.colors.textSecondary,
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
