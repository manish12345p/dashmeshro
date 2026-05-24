import 'package:flutter/material.dart';

class RemarksDateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final TextEditingController remarksController;

  const RemarksDateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.remarksController,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'mm/dd/yyyy';
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$month/$day/$year';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF004A85),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Remarks & Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Service Date Section
          const Text(
            'SERVICE DATE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
              letterSpacing: 0.5,
            ),
          ),
          
          const SizedBox(height: 8),
          
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, color: Color(0xFF003865), size: 18),
                      const SizedBox(width: 12),
                      Text(
                        _formatDate(selectedDate),
                        style: TextStyle(
                          color: selectedDate == null ? Colors.black26 : Colors.black87,
                          fontSize: 13,
                          fontWeight: selectedDate == null ? FontWeight.normal : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.calendar_month_outlined, color: Colors.black38, size: 18),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Detailed Remarks Section
          const Text(
            'DETAILED REMARKS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
              letterSpacing: 0.5,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: remarksController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Describe the service requirements or observations...',
                hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
