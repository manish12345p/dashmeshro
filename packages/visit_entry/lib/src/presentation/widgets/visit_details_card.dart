import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import '../bloc/visit_entry_bloc.dart';
import '../bloc/visit_entry_event.dart';

class ServiceDetailsCard extends StatefulWidget {
  const ServiceDetailsCard({super.key});

  @override
  State<ServiceDetailsCard> createState() => _ServiceDetailsCardState();
}

class _ServiceDetailsCardState extends State<ServiceDetailsCard> {
  final _fixesController = TextEditingController();
  final _totalAmountController = TextEditingController();
  final _amountPaidController = TextEditingController();
  final _amountPendingController = TextEditingController();
  final _equipmentsController = TextEditingController();

  @override
  void dispose() {
    _fixesController.dispose();
    _totalAmountController.dispose();
    _amountPaidController.dispose();
    _amountPendingController.dispose();
    _equipmentsController.dispose();
    super.dispose();
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: context.colors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _syncController(TextEditingController controller, double stateValue) {
    final stateStr = stateValue == 0 ? '' : (stateValue % 1 == 0 ? stateValue.toInt().toString() : stateValue.toStringAsFixed(2));
    final currentVal = double.tryParse(controller.text) ?? 0.0;
    
    if (currentVal != stateValue) {
      controller.value = TextEditingValue(
        text: stateStr,
        selection: TextSelection.collapsed(offset: stateStr.length),
      );
    }
  }

  InputDecoration _baseDecoration({
    required BuildContext context,
    String? hintText,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: context.colors.textTertiary, fontSize: 14),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: context.colors.surface,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.colors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.colors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.colors.primary, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: context.colors.textSecondary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: context.colors.surface,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: BlocListener<VisitEntryBloc, VisitEntryState>(
          listenWhen: (prev, curr) => 
              prev.totalAmount != curr.totalAmount || 
              prev.amountPaid != curr.amountPaid || 
              prev.amountPending != curr.amountPending ||
              curr.status == VisitEntryStatus.success,
          listener: (context, state) {
            if (state.status == VisitEntryStatus.success) {
              _fixesController.clear();
              _totalAmountController.clear();
              _amountPaidController.clear();
              _amountPendingController.clear();
              _equipmentsController.clear();
            } else {
              _syncController(_totalAmountController, state.totalAmount);
              _syncController(_amountPaidController, state.amountPaid);
              _syncController(_amountPendingController, state.amountPending);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // ── header ──
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.build_circle_rounded,
                    color: context.colors.primary,
                    size: 22,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Service Details',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // ── Fixes ──
            _buildSectionLabel('FIXES / WORK DONE'),
            TextField(
              controller: _fixesController,
              onChanged: (value) {
                context.read<VisitEntryBloc>().add(UpdateFixes(value));
              },
              maxLines: 2,
              decoration: _baseDecoration(
                context: context,
                hintText: 'e.g. Replaced filter, cleaned membrane...',
                prefixIcon: Icon(Icons.handyman_rounded, color: context.colors.primary, size: 20),
              ),
              style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
            ),
            SizedBox(height: 20),

            // ── Total Amount ──
            _buildSectionLabel('TOTAL AMOUNT (₹)'),
            TextField(
              controller: _totalAmountController,
              onChanged: (value) {
                final parsed = double.tryParse(value) ?? 0.0;
                context.read<VisitEntryBloc>().add(UpdateTotalAmount(parsed));
              },
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
              decoration: _baseDecoration(
                context: context,
                hintText: '0.00',
                prefixIcon: Icon(Icons.currency_rupee_rounded, color: context.colors.primary, size: 20),
              ),
              style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
            ),
            SizedBox(height: 20),

            // ── Amount Paid & Pending Row ──
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionLabel('AMOUNT PAID (₹)'),
                      TextField(
                        controller: _amountPaidController,
                        onChanged: (value) {
                          final parsed = double.tryParse(value) ?? 0.0;
                          context.read<VisitEntryBloc>().add(UpdateAmountPaid(parsed));
                        },
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
                        decoration: _baseDecoration(
                          context: context,
                          hintText: '0.00',
                          prefixIcon: Icon(Icons.currency_rupee_rounded, color: context.colors.success, size: 20),
                        ),
                        style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionLabel('AMOUNT PENDING (₹)'),
                      TextField(
                        controller: _amountPendingController,
                        onChanged: (value) {
                          final parsed = double.tryParse(value) ?? 0.0;
                          context.read<VisitEntryBloc>().add(UpdateAmountPending(parsed));
                        },
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
                        decoration: _baseDecoration(
                          context: context,
                          hintText: '0.00',
                          prefixIcon: Icon(Icons.pending_actions_rounded, color: context.colors.error, size: 20),
                        ),
                        style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            BlocBuilder<VisitEntryBloc, VisitEntryState>(
              buildWhen: (prev, curr) => 
                  (prev.amountPaid + prev.amountPending > prev.totalAmount) != 
                  (curr.amountPaid + curr.amountPending > curr.totalAmount),
              builder: (context, state) {
                if (state.amountPaid + state.amountPending > state.totalAmount) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Warning: Paid + Pending exceeds Total Amount',
                      style: TextStyle(
                        color: context.colors.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            
            BlocBuilder<VisitEntryBloc, VisitEntryState>(
              buildWhen: (prev, curr) => prev.amountPending != curr.amountPending || prev.emiAmountPerMonth != curr.emiAmountPerMonth,
              builder: (context, state) {
                if (state.amountPending <= 0) return SizedBox.shrink();
                
                final nextDueDate = DateTime.now().add(const Duration(days: 30));
                final formattedDate = "${nextDueDate.day.toString().padLeft(2, '0')}/${nextDueDate.month.toString().padLeft(2, '0')}/${nextDueDate.year}";

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    _buildSectionLabel('EMI CONFIGURATION'),
                    Container(
                      padding: EdgeInsets.all(16),
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
                              SizedBox(width: 8),
                              Text('First EMI Due Date:', style: TextStyle(fontSize: 14, color: context.colors.textSecondary)),
                              SizedBox(width: 8),
                              Text(formattedDate, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.colors.textPrimary)),
                            ],
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<double>(
                            initialValue: () {
                              final options = [
                                300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0,
                                2000.0, 3000.0, 4000.0, 5000.0, 6000.0, 7000.0, 8000.0, 9000.0, 10000.0
                              ].where((amt) => amt < state.amountPending).toList();
                              if (state.amountPending > 0 && !options.contains(state.amountPending)) {
                                options.add(state.amountPending);
                              }
                              return options.contains(state.emiAmountPerMonth) ? state.emiAmountPerMonth : (options.isNotEmpty ? options.first : null);
                            }(),
                            borderRadius: BorderRadius.circular(20),
                            decoration: _baseDecoration(
                              context: context,
                              hintText: 'Select amount per month',
                              prefixIcon: Icon(Icons.payments_rounded, color: context.colors.primary, size: 20),
                            ),
                            items: () {
                              final options = [
                                300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0,
                                2000.0, 3000.0, 4000.0, 5000.0, 6000.0, 7000.0, 8000.0, 9000.0, 10000.0
                              ].where((amt) => amt < state.amountPending).toList();
                              
                              if (state.amountPending > 0 && !options.contains(state.amountPending)) {
                                options.add(state.amountPending);
                              }
                              options.sort();
                              
                              return options.map((amount) => DropdownMenuItem<double>(
                                    value: amount,
                                    child: Text('₹ ${amount.toInt()} / month'),
                                  )).toList();
                            }(),
                            onChanged: (value) {
                              context.read<VisitEntryBloc>().add(UpdateEmiAmountPerMonth(value));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 20),

            // ── Equipments Used ──
            _buildSectionLabel('EQUIPMENTS USED'),
            TextField(
              controller: _equipmentsController,
              onChanged: (value) {
                context.read<VisitEntryBloc>().add(UpdateEquipmentsUsed(value));
              },
              maxLines: 2,
              decoration: _baseDecoration(
                context: context,
                hintText: 'e.g. Spanner, filter wrench, TDS meter...',
                prefixIcon: Icon(Icons.construction_rounded, color: context.colors.primary, size: 20),
              ),
              style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
            ),
            SizedBox(height: 20),

            // ── Service Duration ──
            _buildSectionLabel('SERVICE DURATION'),
            BlocBuilder<VisitEntryBloc, VisitEntryState>(
              buildWhen: (prev, curr) => prev.serviceDuration != curr.serviceDuration,
              builder: (context, state) {
                return DropdownButtonFormField<String>(
                  value: state.serviceDuration.isEmpty ? null : state.serviceDuration,
                  hint: Text('Select duration'),
                  items: _buildDurationItems(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<VisitEntryBloc>().add(UpdateServiceDuration(val));
                    }
                  },
                  decoration: _baseDecoration(
                    context: context,
                    prefixIcon: Icon(Icons.timer_rounded, color: context.colors.primary, size: 20),
                  ),
                  style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
                  dropdownColor: context.colors.surface,
                  borderRadius: BorderRadius.circular(20),
                );
              },
            ),
            SizedBox(height: 20),

            // ── Guarantee Duration ──
            _buildSectionLabel('GUARANTEE DURATION'),
            BlocBuilder<VisitEntryBloc, VisitEntryState>(
              buildWhen: (prev, curr) => prev.guaranteeDuration != curr.guaranteeDuration,
              builder: (context, state) {
                return DropdownButtonFormField<String>(
                  value: state.guaranteeDuration.isEmpty ? null : state.guaranteeDuration,
                  hint: Text('Select duration'),
                  items: _buildDurationItems(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<VisitEntryBloc>().add(UpdateGuaranteeDuration(val));
                    }
                  },
                  decoration: _baseDecoration(
                    context: context,
                    prefixIcon: Icon(Icons.shield_rounded, color: context.colors.primary, size: 20),
                  ),
                  style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
                  dropdownColor: context.colors.surface,
                  borderRadius: BorderRadius.circular(20),
                );
              },
            ),
          ],
        ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDurationItems() {
    final items = <DropdownMenuItem<String>>[];
    // 1 to 11 months
    for (int i = 1; i <= 11; i++) {
      final label = i == 1 ? '1 Month' : '$i Months';
      items.add(DropdownMenuItem(value: label, child: Text(label)));
    }
    // 1 to 3 years
    for (int i = 1; i <= 3; i++) {
      final label = i == 1 ? '1 Year' : '$i Years';
      items.add(DropdownMenuItem(value: label, child: Text(label)));
    }
    return items;
  }
}
