import 'package:flutter/material.dart';
import '../theme/app_constants.dart';
import '../theme/app_padding.dart';

class SummaryCard extends StatelessWidget {
  final String overlineText;
  final String valueText;
  final String subtitleText;
  final Widget trailingIcon;
  final Color trailingBackgroundColor;
  final Color? borderColor;

  const SummaryCard({
    super.key,
    required this.overlineText,
    required this.valueText,
    required this.subtitleText,
    required this.trailingIcon,
    required this.trailingBackgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: AppPadding.all16,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overlineText.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                ),
              ),
              SizedBox(height: AppPadding.p8),
              Text(
                valueText,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: borderColor != null
                      ? borderColor
                      : null, // Inherit border color if exists (like red for errors)
                ),
              ),
              SizedBox(height: AppPadding.p4),
              Text(
                subtitleText,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: borderColor != null
                      ? borderColor
                      : null, // Apply red text for pending complaints if needed
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: AppPadding.all8,
              decoration: BoxDecoration(
                color: trailingBackgroundColor,
                borderRadius: BorderRadius.circular(
                  AppConstants.borderRadiusSmall,
                ),
              ),
              child: trailingIcon,
            ),
          ),
        ],
      ),
    );
  }
}
