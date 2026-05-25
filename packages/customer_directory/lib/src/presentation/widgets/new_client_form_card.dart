import 'package:flutter/material.dart';

/// Form card with all input fields for creating a new client profile.
class NewClientFormCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController localityController;
  final TextEditingController addressController;
  final TextEditingController notesController;

  const NewClientFormCard({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.localityController,
    required this.addressController,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('FULL NAME'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: nameController,
            hint: 'e.g. Ranbir Singh',
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 20),

          _buildLabel('PHONE NUMBER'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: phoneController,
            hint: '+91 00000-00000',
            icon: Icons.phone_rounded,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),

          _buildLabel('LOCALITY / LANDMARK'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: localityController,
            hint: 'e.g. West Patel Nagar, Near...',
            icon: Icons.location_on_rounded,
          ),
          const SizedBox(height: 20),

          _buildLabel('COMPLETE ADDRESS'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: addressController,
            hint: 'House number, Street, Floor...',
            maxLines: 3,
          ),
          const SizedBox(height: 20),

          _buildLabel('INTERNAL NOTES'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: notesController,
            hint: 'Preferred visit time, vehicle preferences, etc.',
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Color(0xFF64748B),
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFAFB9C5), fontSize: 14),
        prefixIcon: icon != null
            ? Icon(icon, color: const Color(0xFF94A3B8), size: 20)
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: maxLines > 1 ? 14 : 0,
          horizontal: icon != null ? 0 : 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2F80ED), width: 1.5),
        ),
      ),
    );
  }
}
