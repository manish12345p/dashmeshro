import 'package:flutter/material.dart';
import '../theme/app_constants.dart';
import '../theme/app_padding.dart';

class ProgressSummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progressValue;
  final Color progressColor;
  final Color trackColor;
  final Widget? trailingBadge;

  const ProgressSummaryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progressValue,
    required this.progressColor,
    required this.trackColor,
    this.trailingBadge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: AppPadding.all16,
      margin: EdgeInsets.only(bottom: AppPadding.p12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trailingBadge != null) trailingBadge!,
            ],
          ),
          SizedBox(height: AppPadding.p12),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: trackColor,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          SizedBox(height: AppPadding.p8),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
