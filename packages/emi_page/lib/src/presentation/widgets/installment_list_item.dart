import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    final isPaidThisMonth = installment.status == 'paid_this_month';
    final isFullyPaid = installment.status == 'paid';
    final isOverdue = installment.status == 'overdue';
    final isPending = installment.status == 'pending';

    return Container(
      margin: EdgeInsets.only(bottom: AppPadding.p16),
      padding: EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
        color: isOverdue
            ? context.colors.infoBg
            : (isFullyPaid || isPaidThisMonth)
            ? context.colors.successBg
            : context.colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: installment.isRent ? 1.5 : 1.0,
          color: installment.isRent
              ? Colors.deepPurple.shade300
              : isOverdue
              ? context.colors.info
              : (isFullyPaid || isPaidThisMonth)
              ? context.colors.success
              : context.colors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.textSecondary.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Customer info row
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: context.colors.surfaceSecondary,
                child: Text(
                  installment.customerName.isNotEmpty
                      ? installment.customerName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: context.colors.textTertiary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      installment.customerName,
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (installment.serviceName.isNotEmpty) ...[
                      SizedBox(height: 2),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          installment.serviceName,
                          style: TextStyle(
                            color: context.colors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 2),
                    Text(
                      installment.vehicleDetails,
                      style: TextStyle(
                        color: context.colors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Amount + Due Date row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left column: Amount info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      installment.isRent
                          ? 'RENT AMOUNT'
                          : (isFullyPaid ? 'PAID AMOUNT' : 'EMI AMOUNT'),
                      style: TextStyle(
                        color: context.colors.textTertiary,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      currencyFormatter.format(
                        isFullyPaid
                            ? (installment.lastPaymentAmount > 0
                                  ? installment.lastPaymentAmount
                                  : installment.amount)
                            : installment.amount,
                      ),
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (!installment.isRent &&
                        installment.totalAmount > 0 &&
                        !isFullyPaid) ...[
                      SizedBox(height: 2),
                      Text(
                        'Remaining: ${currencyFormatter.format(installment.totalAmount)}',
                        style: TextStyle(
                          color: context.colors.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    if (installment.lastPaymentDateStr.isNotEmpty &&
                        installment.lastPaymentAmount > 0)
                      Padding(
                        padding: EdgeInsets.only(top: AppPadding.p4),
                        child: Text(
                          'Last Paid: ${currencyFormatter.format(installment.lastPaymentAmount)} on ${_formatDateStandard(installment.lastPaymentDateStr)}',
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    if (isPaidThisMonth && !isFullyPaid)
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Next due: ${_formatDate(installment.dueDate)}',
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Right column: Due Date + Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DUE DATE',
                      style: TextStyle(
                        color: context.colors.textTertiary,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),

                    // Fully paid
                    if (isFullyPaid) ...[
                      Text(
                        _formatDate(installment.dueDate),
                        style: TextStyle(
                          color: context.colors.success,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: context.colors.success,
                            size: 10,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '✓ Paid',
                            style: TextStyle(
                              color: context.colors.success,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ]
                    // Paid this month (but more EMIs remain)
                    else if (isPaidThisMonth) ...[
                      Text(
                        _formatDate(installment.dueDate),
                        style: TextStyle(
                          color: context.colors.success,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: context.colors.success,
                            size: 10,
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '✓ Paid',
                              style: TextStyle(
                                color: context.colors.success,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                    // Overdue
                    else if (isOverdue) ...[
                      Text(
                        _formatDate(installment.dueDate),
                        style: TextStyle(
                          color: context.colors.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: context.colors.error,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '⚠ OVERDUE',
                            style: TextStyle(
                              color: context.colors.error,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Overdue by ${_calculateDaysOverdue(installment.dueDate)} days',
                        style: TextStyle(
                          color: context.colors.error,
                          fontSize: 10,
                        ),
                      ),
                    ]
                    // Pending
                    else ...[
                      Text(
                        _formatDate(installment.dueDate),
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: context.colors.warning,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Pending',
                            style: TextStyle(
                              color: context.colors.warning,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Pay button — only for pending and overdue (NOT paid_this_month or fully paid)
          if (isPending || isOverdue) ...[
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showAddPaymentDialog(context);
                    },
                    icon: Icon(
                      Icons.payment,
                      size: 14,
                      color: context.colors.surface,
                    ),
                    label: Text(
                      'Pay Installment',
                      style: TextStyle(
                        color: context.colors.surface,
                        fontSize: 12,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.success,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  String _formatDateStandard(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  int _calculateDaysOverdue(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final today = DateTime.now();
      final diff = DateTime(
        today.year,
        today.month,
        today.day,
      ).difference(DateTime(date.year, date.month, date.day));
      return diff.inDays > 0 ? diff.inDays : 0;
    } catch (_) {
      return 0;
    }
  }

  void _showAddPaymentDialog(BuildContext context) {
    final controller = TextEditingController(
      text: installment.amount.toStringAsFixed(0),
    );
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pay Installment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Show EMI and Total amount context
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          installment.isRent ? 'Rent Amount' : 'EMI Amount',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          currencyFormatter.format(installment.amount),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: context.colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!installment.isRent && installment.totalAmount > 0)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Pending',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currencyFormatter.format(installment.totalAmount),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: context.colors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
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
                            title: const Text(AppStrings.confirmPartialPayment),
                            content: Text(
                              'The amount is ₹${installment.amount.toStringAsFixed(0)}, but you entered ₹${amount.toStringAsFixed(0)}. Are you sure you want to pay less?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(confirmCtx),
                                child: const Text(AppStrings.cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(confirmCtx);
                                  Navigator.pop(sheetContext);
                                  onAddPayment(amount);
                                },
                                child: const Text(AppStrings.confirm),
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
  }
}
