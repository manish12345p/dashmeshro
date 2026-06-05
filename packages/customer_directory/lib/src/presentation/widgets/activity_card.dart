import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/customer.dart';

class ActivityCard extends StatelessWidget {
  final ServiceActivity activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    Color badgeBg;
    Color badgeText;
    IconData leadingIcon;
    Color leadingIconColor;

    final colors = context.colors;
    final serviceColors = context.serviceColors.config;
    final typeLower = activity.serviceType.toLowerCase().trim();

    final config =
        serviceColors[typeLower] ??
        {
          'color': colors.textSecondary,
          'bg': colors.surfaceSecondary,
          'icon': Icons.build_circle_rounded,
        };

    badgeBg = config['bg'] as Color;
    badgeText = config['color'] as Color;
    leadingIconColor = config['color'] as Color;
    leadingIcon = config['icon'] as IconData;

    final dateStr = DateFormat('MMM dd, yyyy').format(activity.serviceDate);

    return Container(
      margin: EdgeInsets.only(bottom: AppPadding.p16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: leadingIconColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: context.colors.textSecondary.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge & Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(leadingIcon, color: leadingIconColor, size: 20),
                    SizedBox(width: 8),
                    Text(
                      activity.serviceType.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Work Done (fixes)
            if (activity.fixes.isNotEmpty) ...[
              Text(
                'WORK DONE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textTertiary,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                activity.fixes,
                style: TextStyle(
                  fontSize: 13,
                  color: context.colors.textSecondary,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),
            ],

            // Equipment Used
            if (activity.equipmentsUsed.isNotEmpty) ...[
              Text(
                'EQUIPMENT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textTertiary,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                activity.equipmentsUsed,
                style: TextStyle(
                  fontSize: 13,
                  color: context.colors.textSecondary,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),
            ],

            // Remarks (Notes)
            if (activity.remarks.isNotEmpty) ...[
              Text(
                'NOTES',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textTertiary,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                activity.remarks,
                style: TextStyle(
                  fontSize: 13,
                  color: context.colors.textSecondary,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),
            ],

            // Guarantee Duration
            if (activity.guaranteeDuration.isNotEmpty) ...[
              Text(
                'GUARANTEE DURATION',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textTertiary,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.shield_rounded,
                    size: 14,
                    color: context.colors.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    activity.guaranteeDuration,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],

            // Amounts
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL AMOUNT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: context.colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₹${activity.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'PAID AMOUNT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: context.colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₹${activity.amountPaid.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: context.colors.success,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
