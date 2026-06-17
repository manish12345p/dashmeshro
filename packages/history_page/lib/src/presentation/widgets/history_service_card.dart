import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/history_item.dart';

class HistoryServiceCard extends StatelessWidget {
  final HistoryItem item;
  final VoidCallback? onTap;

  const HistoryServiceCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final serviceColors = context.serviceColors.config;
    final typeLower = item.serviceType.toLowerCase().trim();

    final config =
        serviceColors[typeLower] ??
        {
          'color': colors.textSecondary,
          'bg': colors.surfaceSecondary,
          'icon': Icons.build_circle_rounded,
        };

    final Color accentColor = config['color'] as Color;
    final Color badgeBg = item.isComplaint
        ? colors.error.withValues(alpha: 0.1)
        : config['bg'] as Color;
    final IconData leadingIcon = item.isComplaint
        ? Icons.warning_amber_rounded
        : config['icon'] as IconData;
    final Color iconColor = item.isComplaint ? colors.error : accentColor;

    final bool isCompleted =
        item.status.toLowerCase() == 'completed' ||
        item.status.toLowerCase() == 'resolved' ||
        item.status.toLowerCase() == 'confirmed';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppPadding.p12),
        decoration: BoxDecoration(
          color: item.isComplaint
              ? colors.error.withValues(alpha: 0.03)
              : colors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            bottomLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomRight: const Radius.circular(20),
          ),
          border: item.isComplaint
              ? Border.all(
                  color: colors.error.withValues(alpha: 0.5), width: 1.5)
              : Border(left: BorderSide(color: iconColor, width: 4)),
          boxShadow: [
            BoxShadow(
              color: colors.textSecondary.withValues(alpha: 0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Service Type Badge + Status Chip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Service Type Badge
                  Row(
                    children: [
                      Icon(leadingIcon, color: iconColor, size: 20),
                      const SizedBox(width: 8),
                      if (item.serviceType.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.serviceType.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: iconColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                  // Status Chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? colors.success.withValues(alpha: 0.1)
                          : colors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isCompleted
                              ? Icons.check_circle_rounded
                              : Icons.schedule_rounded,
                          size: 12,
                          color: isCompleted ? colors.success : colors.warning,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isCompleted ? 'Complete' : 'Pending',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color:
                                isCompleted ? colors.success : colors.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Customer Name
              Row(
                children: [
                  Icon(
                    Icons.person_rounded,
                    size: 16,
                    color: colors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      item.customerName.isNotEmpty
                          ? item.customerName
                          : 'Unknown',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              // Address
              if (item.customerAddress.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: colors.textTertiary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item.customerAddress,
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],

              // Note/Remarks
              if (item.note.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'NOTE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: colors.textTertiary,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.note,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              // Service Duration
              if (item.serviceDuration.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Duration: ${item.serviceDuration}',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],

              // Amounts Row
              if (item.totalAmount > 0 || item.amountPending > 0) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Total Amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: colors.textTertiary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹${item.totalAmount.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      // Paid Amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'PAID',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: colors.textTertiary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹${item.amountPaid.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colors.success,
                            ),
                          ),
                        ],
                      ),
                      // Pending Amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'PENDING',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: colors.textTertiary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹${item.amountPending.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: item.amountPending > 0
                                  ? colors.error
                                  : colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
