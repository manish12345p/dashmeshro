import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:core_ui/core_ui.dart';
import 'package:intl/intl.dart';
import 'package:visit_entry/visit_entry.dart';
import '../../domain/entities/customer.dart';

class ActivityCard extends StatelessWidget {
  final ServiceActivity activity;
  final String customerId;
  final String customerName;
  final String customerLocality;

  const ActivityCard({
    super.key, 
    required this.activity,
    required this.customerId,
    required this.customerName,
    required this.customerLocality,
  });

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

    // Override colors if it's a complaint
    if (activity.isComplaint) {
      badgeBg = context.colors.error.withOpacity(0.1);
      badgeText = context.colors.error;
      leadingIconColor = context.colors.error;
      leadingIcon = Icons.warning_amber_rounded;
    }

    final bool isEmptyService = activity.serviceType.trim().isEmpty;

    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: activity.isComplaint 
            ? context.colors.error.withOpacity(0.03) 
            : context.colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isEmptyService && !activity.isComplaint ? 16 : 20),
          bottomLeft: Radius.circular(isEmptyService && !activity.isComplaint ? 16 : 20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: activity.isComplaint
            ? Border.all(color: context.colors.error.withOpacity(0.5), width: 1.5)
            : (isEmptyService ? null : Border(left: BorderSide(color: leadingIconColor, width: 4))),
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
                Flexible(
                  child: Row(
                    children: [
                      Icon(leadingIcon, color: leadingIconColor, size: 20),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          activity.serviceType.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: context.colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      dateStr,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (DateTime.now().difference(activity.serviceDate).inDays <= 5) ...[
                      SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          EditVisitDialog.show(
                            context,
                            customerId: customerId,
                            serviceId: activity.id,
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: context.colors.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),

            // Equipment Used

            // Equipment Used
            if (activity.fixes.isNotEmpty) ...[
              Text(
                'FAULT',
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

            // Remarks (Notes)
            if (activity.remarks.isNotEmpty) ...[
              Text(
                'INTERNAL NOTE',
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

            // Service Duration
            if (activity.serviceDuration.isNotEmpty) ...[
              Text(
                'SERVICE DURATION',
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
                    Icons.timer_outlined,
                    size: 14,
                    color: context.colors.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    activity.serviceDuration,
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
            const SizedBox(height: 12),
            // Share & Copy actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    final text = _getServiceDetailsText();
                    Share.share(text);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.share, size: 16, color: context.colors.primary),
                        const SizedBox(width: 4),
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: context.colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    final text = _getServiceDetailsText();
                    Clipboard.setData(ClipboardData(text: text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Service details copied successfully')),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copy, size: 16, color: context.colors.primary),
                        const SizedBox(width: 4),
                        Text(
                          'Copy',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: context.colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (isEmptyService && !activity.isComplaint) {
      cardContent = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey.shade400],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 4),
          child: cardContent,
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: AppPadding.p16),
      child: cardContent,
    );
  }

  String _getServiceDetailsText() {
    final buffer = StringBuffer();
    buffer.writeln('Name: $customerName');
    if (customerLocality.isNotEmpty) {
      buffer.writeln('Locality: $customerLocality');
    }
    final dateStr = DateFormat('dd/MM/yyyy').format(activity.serviceDate);
    buffer.writeln('Service Date: $dateStr');
    buffer.writeln('Amount: ₹${activity.totalAmount.toStringAsFixed(2)}');
    if (activity.serviceType.isNotEmpty) {
      buffer.writeln('Service Type: ${activity.serviceType}');
    }
    if (activity.fixes.isNotEmpty) {
      buffer.writeln('Fault: ${activity.fixes}');
    }
    if (activity.remarks.isNotEmpty) {
      buffer.writeln('Note: ${activity.remarks}');
    }
    if (activity.serviceDuration.isNotEmpty) {
      buffer.writeln('Duration: ${activity.serviceDuration}');
    }
    if (activity.guaranteeDuration.isNotEmpty) {
      buffer.writeln('Guarantee: ${activity.guaranteeDuration}');
    }
    buffer.writeln('Paid: ₹${activity.amountPaid.toStringAsFixed(2)}');
    return buffer.toString().trim();
  }
}
