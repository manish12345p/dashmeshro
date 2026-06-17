import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/emi_dashboard_data.dart';

class InstallmentListItem extends StatelessWidget {
  final ActiveInstallment installment;
  final VoidCallback onRemind;
  final VoidCallback onMarkPaid;
  final Function(double) onAddPayment;

  const InstallmentListItem({
    super.key,
    required this.installment,
    required this.onRemind,
    required this.onMarkPaid,
    required this.onAddPayment,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = installment.dueDate.split('T').first;

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
                InkWell(
                  onTap: () {
                    if (installment.customerId.isNotEmpty) {
                      context.push('/customers/${installment.customerId}');
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          installment.customerName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.colors.primary,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 10, color: context.colors.primary),
                    ],
                  ),
                ),
                if (installment.serviceName.isNotEmpty) ...[
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      installment.serviceName,
                      style: TextStyle(
                        color: context.colors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 4),
                Text(
                  'Due: $dateStr',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Status: ${installment.status}',
                  style: TextStyle(
                    color: context.colors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                if (installment.totalAmount > 0) ...[
                  SizedBox(height: 4),
                  Text(
                    'Total: ₹${installment.totalAmount.toStringAsFixed(0)}',
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
                '₹${installment.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: context.colors.error,
                ),
              ),
              SizedBox(width: 12),
              if (installment.status != 'paid')
                InkWell(
                  onTap: () {
                    _showPartialPaymentDialog(context, installment);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
  }

  void _showPartialPaymentDialog(
    BuildContext context,
    ActiveInstallment installment,
  ) {
    final TextEditingController controller = TextEditingController(
      text: installment.amount.toStringAsFixed(0),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Record Payment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount to Pay',
                    prefixText: '₹ ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: context.colors.textSecondary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final amount = double.tryParse(controller.text) ?? 0.0;
                          if (amount > 0 && amount < installment.amount) {
                            showDialog(
                              context: sheetContext,
                              builder: (confirmCtx) => AlertDialog(
                                title: const Text('Partial Payment'),
                                content: Text(
                                  'The amount is ₹${installment.amount.toStringAsFixed(0)}, but you entered ₹${amount.toStringAsFixed(0)}. Are you sure you want to pay less?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(confirmCtx),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(confirmCtx);
                                      Navigator.pop(sheetContext);
                                      onAddPayment(amount);
                                    },
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            Navigator.pop(sheetContext);
                            onAddPayment(amount);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colors.primaryDark,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
