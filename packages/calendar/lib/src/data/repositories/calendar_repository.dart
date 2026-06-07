import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/schedule_item.dart';
import '../../domain/repositories/calendar_repository_interface.dart';

class CalendarRepository implements ICalendarRepository {
  final FirebaseFirestore _firestore;

  CalendarRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

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
              final notifDateStr = data['notificationDate'] as String? ?? '';
              final serviceType =
                  data['serviceType'] as String? ??
                  data['service_type'] as String? ??
                  'General';

              DateTime? serviceDate;
              try {
                if (dateStr.isNotEmpty) serviceDate = DateTime.parse(dateStr);
              } catch (_) {}

              DateTime? notifDate;
              try {
                if (notifDateStr.isNotEmpty) {
                  notifDate = DateTime.parse(notifDateStr);
                }
              } catch (_) {}

              if (notifDate != null &&
                  notifDate.year == year &&
                  notifDate.month == month) {
                customerItems.add(
                  ScheduleItem(
                    id: doc.id,
                    name: customerName,
                    machineId: customerAddress.isNotEmpty
                        ? customerAddress
                        : (data['machine_id'] as String? ?? 'N/A'),
                    time: 'Upcoming',
                    category: serviceType,
                    badgeLabel: serviceType.toUpperCase(),
                    status: data['status'] as String? ?? 'pending',
                    date: notifDate,
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
          print('Firestore error in getSchedulesForMonth: $error');
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
