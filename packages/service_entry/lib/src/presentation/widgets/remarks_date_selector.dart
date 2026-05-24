import 'package:flutter/material.dart';

class RemarksDateSelectorWidget extends StatefulWidget {
  const RemarksDateSelectorWidget({super.key});

  @override
  State<RemarksDateSelectorWidget> createState() =>
      _RemarksDateSelectorWidgetState();
}

class _RemarksDateSelectorWidgetState extends State<RemarksDateSelectorWidget> {
  static const Color _primaryColor = Color(0xFF2F80ED);

  DateTime? _selectedDate;
  String _selectedPriority = 'Standard';
  final TextEditingController _remarksController = TextEditingController();

  final List<String> _priorityOptions = ['Standard', 'High', 'Urgent'];

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String get _formattedDate {
    if (_selectedDate == null) return 'mm/dd/yyyy';
    final d = _selectedDate!;
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '$mm/$dd/${d.year}';
  }

  // ───────────────────────────── build helpers ──────────────────────────────

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  InputDecoration _baseDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryColor, width: 1.5),
      ),
    );
  }

  // ─────────────────────────────── fields ───────────────────────────────────

  Widget _buildDateField() {
    return GestureDetector(
      onTap: _pickDate,
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          decoration: _baseDecoration(
            hintText: _formattedDate,
            suffixIcon: Icon(
              Icons.calendar_today_rounded,
              color: _primaryColor,
              size: 20,
            ),
          ),
          controller: TextEditingController(text: _formattedDate == 'mm/dd/yyyy' ? '' : _formattedDate),
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedPriority,
      decoration: _baseDecoration(
        prefixIcon: Icon(
          Icons.settings_rounded,
          color: _primaryColor,
          size: 20,
        ),
      ),
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      items: _priorityOptions
          .map(
            (p) => DropdownMenuItem(
              value: p,
              child: Text(p),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) setState(() => _selectedPriority = value);
      },
    );
  }

  Widget _buildRemarksField() {
    return TextField(
      controller: _remarksController,
      maxLines: 3,
      decoration: _baseDecoration(
        hintText: 'Detail any mechanical issues or special instructions..',
      ),
      style: const TextStyle(fontSize: 14, color: Colors.black87),
    );
  }

  // ─────────────────────────────── build ────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── header ──
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.edit_note_rounded,
                    color: _primaryColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '3. Remarks & Date',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── service date ──
            _buildSectionLabel('SERVICE DATE'),
            _buildDateField(),

            const SizedBox(height: 20),

            // ── priority level ──
            _buildSectionLabel('PRIORITY LEVEL'),
            _buildPriorityDropdown(),

            const SizedBox(height: 20),

            // ── internal remarks ──
            _buildSectionLabel('INTERNAL REMARKS'),
            _buildRemarksField(),
          ],
        ),
      ),
    );
  }
}
