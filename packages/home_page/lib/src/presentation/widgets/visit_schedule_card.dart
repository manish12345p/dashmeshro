import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core/core.dart';
import '../../domain/entities/home_data.dart';

class VisitScheduleCard extends StatefulWidget {
  final NotificationItem item;

  const VisitScheduleCard({super.key, required this.item});

  @override
  State<VisitScheduleCard> createState() => _VisitScheduleCardState();
}

class _VisitScheduleCardState extends State<VisitScheduleCard> {
  bool isDismissed = false;

  @override
  @override
  void didUpdateWidget(covariant VisitScheduleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.isDismissed != oldWidget.item.isDismissed) {
      isDismissed = widget.item.isDismissed;
    }
  }

  @override
  void initState() {
    super.initState();
    isDismissed = widget.item.isDismissed;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      color: isDismissed ? Colors.grey.shade200 : Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: isDismissed,
                activeColor: Colors.grey,
                onChanged: (val) {
                  setState(() {
                    isDismissed = val ?? false;
                  });
                  // Update Firestore
                  try {
                    if (widget.item.serviceId.startsWith('reminder_')) {
                      // It's a dynamic 3-month reminder. Save dismissal to customer doc.
                      if (val == true) {
                        FirebaseFirestore.instance
                            .collection('Customer')
                            .doc(widget.item.customerId)
                            .set({
                          'lastDismissedReminder': widget.item.notificationDate,
                        }, SetOptions(merge: true));
                      } else {
                        FirebaseFirestore.instance
                            .collection('Customer')
                            .doc(widget.item.customerId)
                            .set({
                          'lastDismissedReminder': FieldValue.delete(),
                        }, SetOptions(merge: true));
                      }
                    } else {
                      FirebaseFirestore.instance
                          .collection('Customer')
                          .doc(widget.item.customerId)
                          .collection('services')
                          .doc(widget.item.serviceId)
                          .update({'isDismissed': val ?? false});
                    }
                  } catch (_) {}
                },
              ),
            ),
            const SizedBox(width: 10),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.customerName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      decoration: isDismissed
                          ? TextDecoration.lineThrough
                          : null,
                      color: isDismissed
                          ? Colors.grey.shade500
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.build_circle_outlined,
                        size: 14,
                        color: isDismissed
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.item.serviceType,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDismissed
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (widget.item.address.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: isDismissed
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.item.address,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDismissed
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (widget.item.phone.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 14,
                          color: isDismissed
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.item.phone,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDismissed
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (widget.item.note.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 14,
                          color: isDismissed
                              ? Colors.grey.shade400
                              : Colors.red.shade400,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.item.note,
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: isDismissed
                                  ? Colors.grey.shade400
                                  : Colors.red.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            // View and WA buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                  ServiceActionRow(
                    phone: widget.item.phone,
                    serviceDetailsText: _getServiceDetailsText(),
                    isDisabled: isDismissed,
                  ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: isDismissed
                      ? null
                      : () {
                          if (widget.item.customerId.isNotEmpty) {
                            context.go('/customers/${widget.item.customerId}');
                          }
                        },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'View',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDismissed
                          ? Colors.grey.shade400
                          : Colors.blue.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  String _getServiceDetailsText() {
    final buffer = StringBuffer();
    buffer.writeln('Name: ${widget.item.customerName}');
    if (widget.item.serviceDate.isNotEmpty) {
      buffer.writeln('Service Date: ${widget.item.serviceDate}');
    } else {
      buffer.writeln('Service Date: ${widget.item.notificationDate}'); // Fallback to due date if no service date
    }
    
    if (widget.item.amount > 0) {
      buffer.writeln('Amount: ₹${widget.item.amount}');
    }
    if (widget.item.serviceType.isNotEmpty) {
      buffer.writeln('Service Type: ${widget.item.serviceType}');
    }
    if (widget.item.note.isNotEmpty) {
      buffer.writeln('Service Note: ${widget.item.note}');
    }
    return buffer.toString().trim();
  }


}
