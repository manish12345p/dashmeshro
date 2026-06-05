import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/mock_schedule_item.dart';

class ServiceScheduleCard extends StatelessWidget {
  final MockScheduleItem item;

  const ServiceScheduleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    Color badgeTextColor;

    if (item.category == 'AMC') {
      badgeColor = const Color(0xFFE6F0FA);
      badgeTextColor = const Color(0xFF00569E);
    } else if (item.category == 'Rent') {
      badgeColor = const Color(0xFFEBF7EE);
      badgeTextColor = const Color(0xFF27AE60);
    } else {
      badgeColor = const Color(0xFFFFF8E7);
      badgeTextColor = const Color(0xFFD48300);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.colors.textSecondary.withValues(alpha: 0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Badge and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.badgeLabel,
                  style: TextStyle(
                    color: badgeTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Text(
                item.time,
                style: TextStyle(
                  color: context.colors.primaryDark,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppPadding.p12),

          // Middle Row: Title (Name)
          Text(
            item.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.colors.textPrimary,
            ),
          ),

          const SizedBox(height: 2),

          // Machine ID
          Text(
            'Machine ID: ${item.machineId}',
            style: TextStyle(
              fontSize: 11,
              color: context.colors.textTertiary,
            ),
          ),

          const SizedBox(height: AppPadding.p16),
          Divider(height: 1, color: context.colors.border),
          const SizedBox(height: AppPadding.p12),

          // Bottom Row: Status and Chevron Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: item.statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item.status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: context.colors.border,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: context.colors.primaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


