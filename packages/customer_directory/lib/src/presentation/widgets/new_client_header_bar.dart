import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

/// Reusable header bar with back arrow, title, and avatar.
/// Used on full-screen pages that sit outside the shell (no navbar).
class NewClientHeaderBar extends StatelessWidget {
  const NewClientHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colors.border),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: context.colors.primaryDark,
              size: 22,
            ),
          ),
        ),
        Text(
          'Dashmesh Mechanix',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
                color: context.colors.textPrimary,
              ),
        ),
        SizedBox(width: 36), // Placeholder to maintain center alignment of title
      ],
    );
  }
}
