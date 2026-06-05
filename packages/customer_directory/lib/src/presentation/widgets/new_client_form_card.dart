import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core_ui/core_ui.dart';

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
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(context, 'FULL NAME'),
          SizedBox(height: 8),
          _buildTextField(
            context: context,
            controller: nameController,
            hint: 'e.g. Ranbir Singh',
            icon: Icons.person_rounded,
          ),
          SizedBox(height: 20),

          _buildLabel(context, 'PHONE NUMBER'),
          SizedBox(height: 8),
          _buildTextField(
            context: context,
            controller: phoneController,
            hint: '9876543210',
            icon: Icons.phone_rounded,
            keyboardType: TextInputType.phone,
            maxLength: 50,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9,\s]')),
            ],
            suffixIcon: IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: context.colors.primary,
              ),
              tooltip: 'Add another number',
              onPressed: () {
                final currentText = phoneController.text;
                if (currentText.isNotEmpty &&
                    !currentText.trim().endsWith(',')) {
                  phoneController.text = '$currentText, ';
                  phoneController.selection = TextSelection.fromPosition(
                    TextPosition(offset: phoneController.text.length),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),

          _buildLabel(context, 'LOCALITY / LANDMARK'),
          SizedBox(height: 8),
          _buildTextField(
            context: context,
            controller: localityController,
            hint: 'e.g. West Patel Nagar, Near...',
            icon: Icons.location_on_rounded,
          ),
          SizedBox(height: 20),

          _buildLabel(context, 'COMPLETE ADDRESS'),
          SizedBox(height: 8),
          _buildTextField(
            context: context,
            controller: addressController,
            hint: 'House number, Street, Floor...',
            maxLines: 3,
          ),
          SizedBox(height: 20),

          _buildLabel(context, 'INTERNAL NOTES'),
          SizedBox(height: 8),
          _buildTextField(
            context: context,
            controller: notesController,
            hint: 'Preferred visit time, vehicle preferences, etc.',
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: context.colors.textSecondary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    Widget? suffixIcon,
    int maxLines = 1,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: context.colors.textTertiary, fontSize: 14),
        prefixIcon: icon != null
            ? Icon(icon, color: context.colors.textTertiary, size: 20)
            : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: context.colors.surface,
        contentPadding: EdgeInsets.symmetric(
          vertical: maxLines > 1 ? 14 : 0,
          horizontal: icon != null ? 0 : 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.colors.primary, width: 1.5),
        ),
      ),
    );
  }
}
