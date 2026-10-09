import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import '../bloc/visit_entry_bloc.dart';
import '../bloc/visit_entry_event.dart';

class RemarksDateSelectorWidget extends StatefulWidget {
  const RemarksDateSelectorWidget({super.key});

  @override
  State<RemarksDateSelectorWidget> createState() =>
      _RemarksDateSelectorWidgetState();
}

class _RemarksDateSelectorWidgetState extends State<RemarksDateSelectorWidget> {
  final TextEditingController _remarksController = TextEditingController();

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, String currentDate) async {
    final today = DateTime.now();
    final initialDate = currentDate.isEmpty
        ? today
        : DateTime.tryParse(currentDate) ?? today;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.colors.primary,
              onPrimary: context.colors.surface,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (context.mounted) {
        context.read<VisitEntryBloc>().add(
          SetDate(picked.toIso8601String().split('T')[0]),
        );
      }
    }
  }

  String _formattedDate(String date) {
    if (date.isEmpty) return 'dd/mm/yyyy';
    final d = DateTime.tryParse(date);
    if (d == null) return 'dd/mm/yyyy';
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }

  // ───────────────────────────── build helpers ──────────────────────────────

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

  InputDecoration _baseDecoration({
    required BuildContext context,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: context.colors.textTertiary, fontSize: 14),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
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

  // ─────────────────────────────── fields ───────────────────────────────────

  Widget _buildDateField() {
    return BlocBuilder<VisitEntryBloc, VisitEntryState>(
      buildWhen: (previous, current) =>
          previous.serviceDate != current.serviceDate,
      builder: (context, state) {
        final formatted = _formattedDate(state.effectiveServiceDate);
        return GestureDetector(
          onTap: () => _pickDate(context, state.effectiveServiceDate),
          child: AbsorbPointer(
            child: TextField(
              readOnly: true,
              decoration: _baseDecoration(
                context: context,
                hintText: formatted,
                suffixIcon: Icon(
                  Icons.calendar_today_rounded,
                  color: context.colors.primary,
                  size: 20,
                ),
              ),
              controller: TextEditingController(
                text: formatted == 'dd/mm/yyyy' ? '' : formatted,
              ),
              style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRemarksField() {
    return BlocBuilder<VisitEntryBloc, VisitEntryState>(
      buildWhen: (prev, curr) => prev.remarks != curr.remarks || curr.status == VisitEntryStatus.success,
      builder: (context, state) {
        if (_remarksController.text != state.remarks) {
          _remarksController.value = TextEditingValue(
            text: state.remarks,
            selection: TextSelection.collapsed(offset: state.remarks.length),
          );
        }
        return TextField(
          controller: _remarksController,
          onChanged: (value) {
            context.read<VisitEntryBloc>().add(UpdateRemarks(value));
          },
          maxLines: 3,
          decoration: _baseDecoration(
            context: context,
            hintText: 'Detail any mechanical issues or special instructions..',
          ),
          style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
        );
      },
    );
  }

  // ─────────────────────────────── build ────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: context.colors.surface,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: BlocListener<VisitEntryBloc, VisitEntryState>(
          listenWhen: (prev, curr) => curr.status == VisitEntryStatus.success,
          listener: (context, state) {
            if (state.status == VisitEntryStatus.success) {
              _remarksController.clear();
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
                      color: context.colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.edit_note_rounded,
                      color: context.colors.primary,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '3. Remarks & Date',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // ── service date ──
              _buildSectionLabel('SERVICE DATE'),
              _buildDateField(),

              SizedBox(height: 20),

              // ── internal remarks ──
              _buildSectionLabel('INTERNAL REMARKS'),
              _buildRemarksField(),
            ],
          ),
        ),
      ),
    );
  }
}
