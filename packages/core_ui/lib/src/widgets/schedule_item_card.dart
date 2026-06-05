import 'package:flutter/material.dart';
import '../theme/app_constants.dart';
import '../theme/app_padding.dart';

class ScheduleItemCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String time;
  final Color accentColor;
  final Widget? trailingBadge;
  final VoidCallback? onViewPressed;
  final VoidCallback? onWhatsAppPressed;
  final bool hasWhatsApp;
  final bool hasView;

  const ScheduleItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.accentColor,
    this.trailingBadge,
    this.onViewPressed,
    this.onWhatsAppPressed,
    this.hasWhatsApp = false,
    this.hasView = false,
  });

  @override
  State<ScheduleItemCard> createState() => _ScheduleItemCardState();
}

class _ScheduleItemCardState extends State<ScheduleItemCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isChecked ? Colors.grey.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        boxShadow: isChecked ? [] : [
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
              color: isChecked ? Colors.grey : widget.accentColor,
            ),
            
            // Checkbox
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                child: Checkbox(
                  value: isChecked,
                  activeColor: Colors.grey,
                  onChanged: (val) {
                    setState(() {
                      isChecked = val ?? false;
                    });
                  },
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon / Badge
                    if (widget.trailingBadge != null) ...[
                      widget.trailingBadge!,
                      const SizedBox(width: AppPadding.p12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: isChecked ? TextDecoration.lineThrough : null,
                              color: isChecked ? Colors.grey : null,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isChecked ? Colors.grey : theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppPadding.p8),
                    // Actions and Time
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.time.split(' ').first,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isChecked ? Colors.grey : null,
                          ),
                        ),
                        if (widget.time.split(' ').length > 1)
                          Text(
                            widget.time.split(' ')[1],
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isChecked ? Colors.grey : null,
                            ),
                          ),
                        if (widget.hasView || widget.hasWhatsApp)
                          const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.hasWhatsApp)
                              IconButton(
                                icon: Icon(
                                  Icons.chat_bubble_outline,
                                  color: isChecked ? Colors.grey : Colors.green.shade600,
                                  size: 20,
                                ),
                                onPressed: isChecked ? null : widget.onWhatsAppPressed,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            if (widget.hasView)
                              TextButton(
                                onPressed: isChecked ? null : widget.onViewPressed,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'View',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isChecked ? Colors.grey : null,
                                  ),
                                ),
                              ),
                          ],
                        ),
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
