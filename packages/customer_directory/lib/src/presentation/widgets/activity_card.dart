import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
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

    switch (activity.activityType) {
      case 'complaint':
        badgeBg = const Color(0xFFFEE2E2);
        badgeText = const Color(0xFFB91C1C);
        leadingIcon = Icons.warning_rounded;
        leadingIconColor = const Color(0xFFDC2626);
        break;
      case 'maintenance':
        badgeBg = const Color(0xFFDCFCE7);
        badgeText = const Color(0xFF15803D);
        leadingIcon = Icons.verified;
        leadingIconColor = const Color(0xFF10B981);
        break;
      case 'receipt':
        badgeBg = const Color(0xFFEFF6FF);
        badgeText = const Color(0xFF1E3A8A);
        leadingIcon = Icons.receipt_long_rounded;
        leadingIconColor = const Color(0xFF3B82F6);
        break;
      case 'installation':
      default:
        badgeBg = const Color(0xFFDBEAFE);
        badgeText = const Color(0xFF1E40AF);
        leadingIcon = Icons.shopping_cart_rounded;
        leadingIconColor = const Color(0xFF2563EB);
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
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
                    const SizedBox(width: 8),
                    Text(
                      activity.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    activity.statusBadge.toUpperCase(),
                    style: TextStyle(
                      color: badgeText,
                      fontSize: 8.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              activity.description,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF475569),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),

            // Bottom metadata (Technician name & Date)
            Row(
              children: [
                const Icon(Icons.person, size: 14, color: Color(0xFF64748B)),
                const SizedBox(width: 4),
                Text(
                  activity.technicianName,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time_filled, size: 14, color: Color(0xFF64748B)),
                const SizedBox(width: 4),
                Text(
                  activity.dateText,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
