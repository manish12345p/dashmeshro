import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_strings.dart';

class DurationDropdownWidget extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final IconData prefixIcon;
  final InputDecoration? decoration;
  final String label;

  const DurationDropdownWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.prefixIcon,
    this.decoration,
    this.label = '',
  });

  static List<DropdownMenuItem<String>> buildDurationItems() {
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

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: (value != null && value!.isNotEmpty) ? value : null,
      hint: const Text(AppStrings.selectDuration),
      items: buildDurationItems(),
      onChanged: onChanged,
      decoration: decoration ?? InputDecoration(
        labelText: label.isNotEmpty ? label : null,
        prefixIcon: Icon(
          prefixIcon,
          color: context.colors.primary,
          size: 20,
        ),
        filled: true,
        fillColor: context.colors.surfaceSecondary.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.colors.primary.withOpacity(0.3),
            width: 1.5,
          ),
        ),
      ),
      style: TextStyle(
        fontSize: 14,
        color: context.colors.textPrimary,
      ),
      dropdownColor: context.colors.surface,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
