import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/emi_dashboard_data.dart';

class InstallmentListItem extends StatelessWidget {
  final ActiveInstallment installment;
  final VoidCallback onRemind;
  final VoidCallback onMarkPaid;
  final void Function(
    double amount,
    String paymentMethod,
    String transactionRef,
    String notes,
  ) onAddPayment;

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
                  SizedBox(height: 2),
                  Text(
                    'Balance: ₹${installment.totalAmount.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: context.colors.error,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${installment.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: context.colors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.call, color: installment.customerPhone.isNotEmpty ? context.colors.primary : context.colors.textTertiary, size: 20),
                    onPressed: installment.customerPhone.isNotEmpty 
                        ? () {
                            PhoneActionHandler.handleAction(
                              context: context,
                              rawNumbers: installment.customerPhone,
                              actionName: 'Call',
                              onSelected: (selectedNumber) async {
                                final url = Uri.parse('tel:$selectedNumber');
                                try {
                                  await launchUrl(url);
                                } catch (e) {
                                  debugPrint('Could not launch Call: $e');
                                }
                              },
                            );
                          }
                        : null,
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                  IconButton(
                    icon: Icon(Icons.message, color: installment.customerPhone.isNotEmpty ? Colors.green : context.colors.textTertiary, size: 20),
                    onPressed: installment.customerPhone.isNotEmpty 
                        ? () {
                            PhoneActionHandler.handleAction(
                              context: context,
                              rawNumbers: installment.customerPhone,
                              actionName: 'WhatsApp',
                              onSelected: (selectedNumber) async {
                                final url = Uri.parse('https://wa.me/91$selectedNumber');
                                try {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                } catch (e) {
                                  debugPrint('Could not launch WhatsApp: $e');
                                }
                              },
                            );
                          }
                        : null,
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    onPressed: () => _showAddPaymentSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.success,
                      foregroundColor: context.colors.surface,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      minimumSize: const Size(60, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Pay', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _PaymentBottomSheet(
        installment: installment,
        onAddPayment: (amount, method, ref, notes) {
          Navigator.pop(sheetContext);
          onAddPayment(amount, method, ref, notes);
        },
      ),
    );
  }
}

class _PaymentBottomSheet extends StatefulWidget {
  final ActiveInstallment installment;
  final void Function(double amount, String paymentMethod, String transactionRef, String notes) onAddPayment;

  const _PaymentBottomSheet({
    required this.installment,
    required this.onAddPayment,
  });

  @override
  State<_PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<_PaymentBottomSheet> {
  late final TextEditingController amountController;
  late final TextEditingController refController;
  late final TextEditingController notesController;
  String paymentMethod = 'Cash';

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: widget.installment.amount.toStringAsFixed(0));
    refController = TextEditingController();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    refController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
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
            const SizedBox(height: 8),
            Text(
              'For ${widget.installment.customerName}',
              style: TextStyle(color: context.colors.textSecondary),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
              decoration: InputDecoration(
                prefixText: '₹ ',
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: paymentMethod,
              decoration: InputDecoration(
                labelText: 'Payment Method',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['Cash', 'UPI', 'Bank Transfer', 'Cheque']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => paymentMethod = val);
              },
            ),
            if (paymentMethod != 'Cash') ...[
              const SizedBox(height: 16),
              TextField(
                controller: refController,
                decoration: InputDecoration(
                  labelText: 'Transaction Ref / UTR',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: 'Notes (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final amount = double.tryParse(amountController.text) ?? 0.0;
                      if (amount > 0 && amount < widget.installment.amount) {
                        showDialog(
                          context: context,
                          builder: (confirmCtx) => AlertDialog(
                            title: const Text('Partial Payment'),
                            content: Text(
                              'The EMI is ₹${widget.installment.amount.toStringAsFixed(0)}, but you entered ₹${amount.toStringAsFixed(0)}. Save anyway?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(confirmCtx),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(confirmCtx); // pop dialog
                                  widget.onAddPayment(amount, paymentMethod, refController.text, notesController.text);
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        widget.onAddPayment(amount, paymentMethod, refController.text, notesController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.primary,
                      foregroundColor: context.colors.surface,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Save Payment'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
