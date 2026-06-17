import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';

class EditVisitDialog extends StatefulWidget {
  final String customerId;
  final String serviceId;

  const EditVisitDialog({
    super.key,
    required this.customerId,
    required this.serviceId,
  });

  static Future<void> show(BuildContext context, {required String customerId, required String serviceId}) {
    return showDialog(
      context: context,
      builder: (context) => EditVisitDialog(customerId: customerId, serviceId: serviceId),
    );
  }

  @override
  State<EditVisitDialog> createState() => _EditVisitDialogState();
}

class _EditVisitDialogState extends State<EditVisitDialog> {
  bool _isLoading = true;
  bool _isSaving = false;
  Map<String, dynamic>? _data;
  
  final _fixesController = TextEditingController();
  final _remarksController = TextEditingController();
  final _amountPaidController = TextEditingController();
  final _amountPendingController = TextEditingController();
  final _totalAmountController = TextEditingController();
  
  List<String> _selectedTypes = [];
  double? _emiAmountPerMonth;
  bool _isDone = false;
  
  static const List<String> _serviceTypes = [
    'Set Change', 'AMC', 'New RO', 'Repair', 'Service', 'Pump',
    'Set Pump', 'New RO Set Change', 'Set SV', 'Install and Set Change',
    'Set & Pump', 'Inline', 'Copper Set', 'Alkaline', 'Alkaline Set',
    'Set SMPS', 'Not Applicable',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
    
    // Add auto-calculation listeners
    _totalAmountController.addListener(_onAmountChanged);
    _amountPaidController.addListener(_onAmountChanged);
  }

  void _onAmountChanged() {
    final total = double.tryParse(_totalAmountController.text) ?? 0.0;
    final paid = double.tryParse(_amountPaidController.text) ?? 0.0;
    
    if (paid > total) {
      // Don't allow paid > total, but don't change text while typing, just compute pending as 0
      if (_amountPendingController.text != '0.0') {
        _amountPendingController.text = '0.0';
        setState((){});
      }
    } else {
      final pending = total - paid;
      final pendingStr = pending == pending.truncateToDouble() 
          ? pending.toInt().toString() 
          : pending.toStringAsFixed(1);
          
      if (_amountPendingController.text != pendingStr) {
        _amountPendingController.text = pendingStr;
        setState((){});
      }
    }
  }

  @override
  void dispose() {
    _totalAmountController.removeListener(_onAmountChanged);
    _amountPaidController.removeListener(_onAmountChanged);
    _fixesController.dispose();
    _remarksController.dispose();
    _amountPaidController.dispose();
    _amountPendingController.dispose();
    _totalAmountController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('Customer')
          .doc(widget.customerId)
          .collection('services')
          .doc(widget.serviceId)
          .get();
          
      if (doc.exists && mounted) {
          final data = doc.data()!;
        setState(() {
          _data = data;
          _fixesController.text = data['fixes'] ?? '';
          _remarksController.text = data['remarks'] ?? '';
          _amountPaidController.text = (data['amountPaid'] ?? 0.0).toString();
          _amountPendingController.text = (data['amountPending'] ?? 0.0).toString();
          _totalAmountController.text = (data['totalAmount'] ?? 0.0).toString();
          
          final sType = data['serviceType'] as String? ?? data['service_type'] as String? ?? '';
          _selectedTypes = sType.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
          
          _isDone = data['status'] == 'completed';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error loading service: $e')));
        Navigator.pop(context);
      }
    }
  }

  Future<void> _saveData() async {
    if (_data == null) return;
    setState(() => _isSaving = true);
    
    try {
      final totalAmount = double.tryParse(_totalAmountController.text) ?? 0.0;
      final amountPaid = double.tryParse(_amountPaidController.text) ?? 0.0;
      final amountPending = double.tryParse(_amountPendingController.text) ?? 0.0;
      
      if (amountPaid > totalAmount || amountPending > totalAmount) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paid or Pending amount cannot exceed Total amount.')),
        );
        return;
      }
      
      final updates = <String, dynamic>{
        'serviceType': _selectedTypes.join(', '),
        'service_type': _selectedTypes.join(', '),
        'fixes': _fixesController.text,
        'remarks': _remarksController.text,
        'amountPaid': amountPaid,
        'amountPending': amountPending,
        'totalAmount': totalAmount,
        'status': _isDone ? 'completed' : 'pending',
      };
      
      if (_isDone && _data!['status'] != 'completed') {
        updates['completedAt'] = DateTime.now().toIso8601String();
      }

      await FirebaseFirestore.instance
          .collection('Customer')
          .doc(widget.customerId)
          .collection('services')
          .doc(widget.serviceId)
          .update(updates);
      
      // Create EMI installment if needed
      if (amountPending > 0 && _data!['amountPending'] != amountPending) {
        try {
          final customerSnap = await FirebaseFirestore.instance.collection('Customer').doc(widget.customerId).get();
          if (customerSnap.exists) {
            final custData = customerSnap.data()!;
            final name = custData['name'] ?? 'Unknown';
            final address = custData['address'] ?? '';
            final phone = custData['number'] ?? '';

            final contactInfo = [
              if (address.toString().isNotEmpty) address,
              if (phone.toString().isNotEmpty) phone,
            ].join(' | ');

            final emiCollection = FirebaseFirestore.instance.collection('installments');
            final emiId = 'emi_${widget.serviceId}';

            double monthlyAmount = amountPending;
            if (_emiAmountPerMonth != null && _emiAmountPerMonth! > 0 && _emiAmountPerMonth! < amountPending) {
              monthlyAmount = _emiAmountPerMonth!;
            }

            final now = DateTime.now();
            DateTime initialDueDate = DateTime(now.year, now.month + 1, now.day);
            final String svcName = _selectedTypes.isNotEmpty ? _selectedTypes.join(', ') : 'Service #${widget.serviceId.substring(0, 5)}';

            await emiCollection.doc(emiId).set({
              'id': emiId,
              'customer_name': name,
              'customer_id': widget.customerId,
              'vehicle_details': contactInfo,
              'service_name': svcName,
              'amount': monthlyAmount,
              'emi_monthly_amount': monthlyAmount,
              'total_amount': amountPending,
              'original_loan_amount': amountPending,
              'status': 'pending',
              'due_date': initialDueDate.toIso8601String(),
              'created_at': now.toIso8601String(),
              'service_id': widget.serviceId,
            });
          }
        } catch (e) {
          // Ignore
        }
      }

      // Record payment if amountPaid > 0 and it changed
      final oldPaid = (_data!['amountPaid'] as num?)?.toDouble() ?? 0.0;
      if (amountPaid > 0 && amountPaid != oldPaid) {
        try {
          final paymentAmount = amountPaid - oldPaid; // Only record the new addition
          if (paymentAmount > 0) {
            await FirebaseFirestore.instance.collection('payments').add({
              'customer_id': widget.customerId,
              'amount': paymentAmount,
              'source': 'visit_edit',
              'reference_id': widget.serviceId,
              'date': DateTime.now().toIso8601String(),
            });
          }
        } catch (e) {
          // ignore
        }
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving: $e')));
        setState(() => _isSaving = false);
      }
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: context.colors.textSecondary, fontSize: 14),
        filled: true,
        fillColor: context.colors.surfaceSecondary.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.textQuaternary.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.textQuaternary.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const AlertDialog(
        content: SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 750),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Visit Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.colors.primaryDark,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service Type', style: TextStyle(fontWeight: FontWeight.bold, color: context.colors.textPrimary)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _serviceTypes.map((type) {
                        final isSelected = _selectedTypes.contains(type);
                        return FilterChip(
                          label: Text(type),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedTypes.add(type);
                              } else {
                                _selectedTypes.remove(type);
                              }
                            });
                          },
                          backgroundColor: context.colors.surfaceSecondary,
                          selectedColor: context.colors.primary.withValues(alpha: 0.15),
                          checkmarkColor: context.colors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? context.colors.primary : context.colors.textSecondary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected ? context.colors.primary.withValues(alpha: 0.5) : Colors.transparent,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    
                    Text('Details', style: TextStyle(fontWeight: FontWeight.bold, color: context.colors.textPrimary)),
                    const SizedBox(height: 12),
                    _buildTextField('Faults / Fixes', _fixesController, maxLines: 2),
                    const SizedBox(height: 16),
                    _buildTextField('Notes / Remarks', _remarksController, maxLines: 2),
                    const SizedBox(height: 24),

                    Text('Financials', style: TextStyle(fontWeight: FontWeight.bold, color: context.colors.textPrimary)),
                    const SizedBox(height: 12),
                    _buildTextField('Total Amount', _totalAmountController, keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Paid', _amountPaidController, keyboardType: TextInputType.number)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField('Pending', _amountPendingController, keyboardType: TextInputType.number)),
                      ],
                    ),
                    if (double.tryParse(_amountPendingController.text) != null && double.parse(_amountPendingController.text) > 0) ...[
                      const SizedBox(height: 20),
                      Text('EMI CONFIGURATION', style: TextStyle(fontWeight: FontWeight.bold, color: context.colors.textPrimary)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.colors.infoBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: context.colors.border),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today_rounded, color: context.colors.primary, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'First EMI Due Date:',
                                  style: TextStyle(fontSize: 14, color: context.colors.textSecondary),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "${DateTime.now().add(const Duration(days: 30)).day.toString().padLeft(2, '0')}/${DateTime.now().add(const Duration(days: 30)).month.toString().padLeft(2, '0')}/${DateTime.now().add(const Duration(days: 30)).year}",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.colors.textPrimary),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<double>(
                              isExpanded: true,
                              value: () {
                                final amountPending = double.parse(_amountPendingController.text);
                                final options = [300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 2000.0, 3000.0, 4000.0, 5000.0, 6000.0, 7000.0, 8000.0, 9000.0, 10000.0]
                                    .where((amt) => amt < amountPending).toList();
                                if (amountPending > 0 && !options.contains(amountPending)) {
                                  options.add(amountPending);
                                }
                                options.sort();
                                return options.contains(_emiAmountPerMonth) ? _emiAmountPerMonth : (options.isNotEmpty ? options.first : null);
                              }(),
                              decoration: InputDecoration(
                                hintText: 'Select amount per month',
                                prefixIcon: Icon(Icons.payments_rounded, color: context.colors.primary, size: 20),
                                filled: true,
                                fillColor: context.colors.surface,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              items: () {
                                final amountPending = double.parse(_amountPendingController.text);
                                final options = [300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 2000.0, 3000.0, 4000.0, 5000.0, 6000.0, 7000.0, 8000.0, 9000.0, 10000.0]
                                    .where((amt) => amt < amountPending).toList();
                                if (amountPending > 0 && !options.contains(amountPending)) {
                                  options.add(amountPending);
                                }
                                options.sort();
                                return options.map((amount) => DropdownMenuItem<double>(
                                  value: amount,
                                  child: Text(
                                    '₹ ${amount.toInt()} / month',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )).toList();
                              }(),
                              onChanged: (value) {
                                setState(() {
                                  _emiAmountPerMonth = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // Footer
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: context.colors.primary,
                    elevation: 0,
                  ),
                  child: _isSaving 
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
