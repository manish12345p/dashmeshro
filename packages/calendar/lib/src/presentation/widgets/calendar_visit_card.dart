import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/schedule_item.dart';

class CalendarVisitCard extends StatefulWidget {
  final ScheduleItem item;

  const CalendarVisitCard({super.key, required this.item});

  @override
  State<CalendarVisitCard> createState() => _CalendarVisitCardState();
}

class _CalendarVisitCardState extends State<CalendarVisitCard> {
  bool isDismissed = false;

  @override
  @override
  void didUpdateWidget(covariant CalendarVisitCard oldWidget) {
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
                    final serviceId = widget.item.id.replaceFirst('notif_', '');
                    FirebaseFirestore.instance
                        .collection('Customer')
                        .doc(widget.item.customerId)
                        .collection('services')
                        .doc(serviceId)
                        .update({'isDismissed': val ?? false});
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
                    widget.item.name,
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
                          widget.item.category,
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
                  if (widget.item.machineId.isNotEmpty &&
                      widget.item.machineId != 'N/A') ...[
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
                            widget.item.machineId,
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
                ],
              ),
            ),
            // View and WA buttons
            Column(
              children: [
                if (widget.item.phone.isNotEmpty)
                  IconButton(
                    icon: Icon(
                      Icons.chat_bubble_outline,
                      color: isDismissed
                          ? Colors.grey.shade400
                          : Colors.green.shade600,
                      size: 20,
                    ),
                    onPressed: isDismissed
                        ? null
                        : () async {
                            final rawNumber = widget.item.phone
                                .split(',')
                                .first
                                .trim();
                            final cleanNum = rawNumber.replaceAll(
                              RegExp(r'[^0-9]'),
                              '',
                            );
                            final finalNum = cleanNum.length == 10
                                ? '91$cleanNum'
                                : cleanNum;
                            final url = Uri.parse('https://wa.me/$finalNum');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
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
}
