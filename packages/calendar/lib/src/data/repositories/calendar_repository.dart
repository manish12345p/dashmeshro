import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/schedule_item.dart';
import '../../domain/repositories/calendar_repository_interface.dart';

class CalendarRepository implements ICalendarRepository {
  final FirebaseFirestore _firestore;

  CalendarRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Calculates (dateStr + durationStr) → DateTime.
  /// durationStr format: "3 months" or "1 year"
  DateTime? _calculateDueDate(String dateStr, String durationStr) {
    if (dateStr.isEmpty || durationStr.isEmpty) return null;
    try {
      final date = DateTime.parse(dateStr);
      final parts = durationStr.trim().split(' ');
      if (parts.length != 2) return null;
      final value = int.tryParse(parts[0]) ?? 0;
      final unit = parts[1].toLowerCase();
      if (unit.contains('month')) {
        return DateTime(date.year, date.month + value, date.day);
      } else if (unit.contains('year')) {
        return DateTime(date.year + value, date.month, date.day);
      }
    } catch (_) {}
    return null;
  }

  @override
  Stream<List<ScheduleItem>> getSchedulesForMonth(int year, int month) {
    return _firestore
        .collection('Customer')
        .snapshots()
        .asyncMap((customersSnap) async {
          final futures = customersSnap.docs.map((customerDoc) async {
            final customerItems = <ScheduleItem>[];
            final customerData = customerDoc.data();
            final customerName = customerData['name'] as String? ?? 'Unknown';
            final customerAddress = customerData['address'] as String? ?? '';

            final servicesSnap = await customerDoc.reference
                .collection('services')
                .get();

            for (var doc in servicesSnap.docs) {
              final data = doc.data();
              final dateStr =
                  data['serviceDate'] as String? ??
                  data['service_date'] as String? ??
                  '';
              final serviceDuration =
                  data['serviceDuration'] as String? ?? '';
              final serviceType =
                  data['serviceType'] as String? ??
                  data['service_type'] as String? ??
                  'General';

              final serviceDate = DateTime.tryParse(dateStr);
              
              // Compute exact due date from serviceDate + serviceDuration
              final dueDate = _calculateDueDate(dateStr, serviceDuration);

              if (dueDate != null &&
                  dueDate.year == year &&
                  dueDate.month == month) {
                customerItems.add(
                  ScheduleItem(
                    id: doc.id + '_due',
                    name: customerName,
                    machineId: customerAddress.isNotEmpty
                        ? customerAddress
                        : (data['machine_id'] as String? ?? 'N/A'),
                    time: 'Due ${dueDate.day}/${dueDate.month}/${dueDate.year}',
                    category: serviceType,
                    badgeLabel:
                        '$serviceType${serviceDuration.isNotEmpty ? ' · $serviceDuration' : ''}',
                    status: data['status'] as String? ?? 'pending',
                    date: dueDate,
                    phone: customerData['number'] as String? ?? '',
                    customerId: customerDoc.id,
                    isDismissed: data['isDismissed'] as bool? ?? false,
                  ),
                );
              }
            }
            return customerItems;
          });

          final nestedItems = await Future.wait(futures);
          return nestedItems.expand((i) => i).toList();
        })
        .handleError((error) {
          debugPrint('Firestore error in getSchedulesForMonth: $error');
          return <ScheduleItem>[];
        });
  }

  @override
  Future<void> dismissSchedule(String customerId, String serviceId, bool isDismissed) async {
    final cleanServiceId = serviceId.replaceFirst('notif_', '');
    await _firestore
        .collection('Customer')
        .doc(customerId)
        .collection('services')
        .doc(cleanServiceId)
        .update({'isDismissed': isDismissed});
  }
}
