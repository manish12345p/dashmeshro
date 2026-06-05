import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

/// Security and Cloud Sync info cards shown at the bottom.
class NewClientInfoCards extends StatelessWidget {
  const NewClientInfoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Security card
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [context.colors.primaryDark, context.colors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SECURITY',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: context.colors.textTertiary,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                ),
                SizedBox(height: 8),
                Icon(Icons.shield_rounded, color: Colors.white, size: 24),
                SizedBox(height: 8),
                Text(
                  'Data encrypted\nand stored\nsecurely.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 14),
        // Cloud Sync card
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.infoBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colors.info),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CLOUD SYNC',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: context.colors.primary,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                ),
                SizedBox(height: 8),
                Icon(Icons.cloud_sync_rounded, color: context.colors.primary, size: 24),
                SizedBox(height: 8),
                Text(
                  'Auto-synced\nacross all your\ndevices.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.colors.textSecondary,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
