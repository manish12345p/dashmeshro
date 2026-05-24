import 'package:flutter/material.dart';
import '../theme/app_constants.dart';
import '../theme/app_padding.dart';

class ScheduleItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final Color accentColor;
  final Widget? trailingBadge;

  const ScheduleItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.accentColor,
    this.trailingBadge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Accent Line
            Container(
              width: 4,
              color: accentColor,
            ),
            Expanded(
              child: Padding(
                padding: AppPadding.all16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon / Badge
                    if (trailingBadge != null) ...[
                      trailingBadge!,
                      const SizedBox(width: AppPadding.p12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppPadding.p8),
                    // Time block
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          time.split(' ').first,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          time.split(' ').length > 1 ? time.split(' ')[1] : '',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (trailingBadge != null && trailingBadge is! Container) // Just a placeholder check if we want status pill under time
                          const SizedBox(height: 4),
                        // Here we can put 'URGENT' pill if passed through other params, but the design shows badge under time or beside
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
