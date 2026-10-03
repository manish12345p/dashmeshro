import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import '../../domain/entities/schedule_item.dart';
import 'calendar_remote_data_source.dart';

class FirebaseCalendarRemoteDataSource implements ICalendarRemoteDataSource {
  final FirebaseFirestore _firestore;

  FirebaseCalendarRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

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
          // Create a lookup for customers
          final customerDataMap = <String, Map<String, dynamic>>{};
          for (var doc in customersSnap.docs) {
            customerDataMap[doc.id] = doc.data();
          }

          // Fetch ALL services across ALL customers in a single query
          final servicesSnap = await _firestore.collectionGroup('services').get();

          final customerItems = <ScheduleItem>[];
          final latestServiceDates = <String, DateTime>{};
          final customersWithExplicitItems = <String>{};

          for (var doc in servicesSnap.docs) {
            final customerId = doc.reference.parent.parent?.id;
            if (customerId == null || !customerDataMap.containsKey(customerId)) continue;

            final customerData = customerDataMap[customerId]!;
            final customerName = customerData['name'] as String? ?? 'Unknown';
            final customerAddress = customerData['address'] as String? ?? '';
            
            final data = doc.data();
            final dateStr = data['serviceDate'] as String? ?? data['service_date'] as String? ?? '';
            final serviceDuration = data['serviceDuration'] as String? ?? '';
            final serviceType = data['serviceType'] as String? ?? data['service_type'] as String? ?? 'General';
            final status = data['status'] as String? ?? 'pending';

            if (dateStr.isNotEmpty) {
              try {
                final date = DateTime.parse(dateStr);
                final currentLatest = latestServiceDates[customerId];
                if (currentLatest == null || date.isAfter(currentLatest)) {
                  latestServiceDates[customerId] = date;
                }
              } catch (_) {}
            }

            final dueDate = _calculateDueDate(dateStr, serviceDuration);
            bool addedItem = false;
            
            if (dueDate != null && dueDate.year == year && dueDate.month == month) {
              customerItems.add(
                ScheduleItem(
                  id: doc.id + '_due',
                  name: customerName,
                  machineId: customerAddress.isNotEmpty
                      ? customerAddress
                      : (data['machine_id'] as String? ?? 'N/A'),
                  time: 'Due ${dueDate.day}/${dueDate.month}/${dueDate.year}',
                  category: serviceType,
                  badgeLabel: '$serviceType${serviceDuration.isNotEmpty ? ' · $serviceDuration' : ''}',
                  status: status,
                  date: dueDate,
                  phone: customerData['number'] as String? ?? '',
                  customerId: customerId,
                  isDismissed: data['isDismissed'] as bool? ?? false,
                ),
              );
              addedItem = true;
            } else if (status == 'pending' && dateStr.isNotEmpty) {
               try {
                 final pendingDate = DateTime.parse(dateStr);
                 if (pendingDate.year == year && pendingDate.month == month) {
                    customerItems.add(
                      ScheduleItem(
                        id: doc.id + '_pending',
                        name: customerName,
                        machineId: customerAddress.isNotEmpty
                            ? customerAddress
                            : (data['machine_id'] as String? ?? 'N/A'),
                        time: '${pendingDate.day}/${pendingDate.month}/${pendingDate.year}',
                        category: serviceType,
                        badgeLabel: 'Pending: $serviceType',
                        status: status,
                        date: pendingDate,
                        phone: customerData['number'] as String? ?? '',
                        customerId: customerId,
                        isDismissed: data['isDismissed'] as bool? ?? false,
                      ),
                    );
                    addedItem = true;
                 }
               } catch (_) {}
            }
            
            if (addedItem) {
              customersWithExplicitItems.add(customerId);
            }
          }

          // Generate 3-month recurring reminders for all customers
          for (var customerId in customerDataMap.keys) {
            // Skip auto-reminders if customer already has an explicitly scheduled visit this month
            if (customersWithExplicitItems.contains(customerId)) continue;

            final customerData = customerDataMap[customerId]!;
            final customerName = customerData['name'] as String? ?? 'Unknown';
            final customerAddress = customerData['address'] as String? ?? '';

            DateTime baseDate;
            if (latestServiceDates.containsKey(customerId)) {
              baseDate = latestServiceDates[customerId]!;
            } else {
              final createdAtStr = customerData['createdAt'] ?? customerData['created_at'];
              if (createdAtStr != null && createdAtStr is String && createdAtStr.isNotEmpty) {
                baseDate = DateTime.tryParse(createdAtStr) ?? DateTime.now();
              } else if (createdAtStr != null && createdAtStr is Timestamp) {
                baseDate = createdAtStr.toDate();
              } else {
                baseDate = DateTime.now();
              }
            }

            final reminders = ReminderUtils.getRemindersForMonth(baseDate, year, month);
            for (var date in reminders) {
              customerItems.add(
                ScheduleItem(
                  id: '${customerId}_3month_due',
                  name: customerName,
                  machineId: customerAddress.isNotEmpty
                      ? customerAddress
                      : (customerData['machine_id'] as String? ?? 'N/A'),
                  time: 'Due ${date.day}/${date.month}/${date.year}',
                  category: '3-Month Recurring Service',
                  badgeLabel: '3-Month Recurring Service',
                  status: 'pending',
                  date: date,
                  phone: customerData['number'] as String? ?? '',
                  customerId: customerId,
                  isDismissed: false,
                ),
              );
            }
          }

          // Deduplicate the items to handle duplicate customer documents in Firestore
          final uniqueItems = <String, ScheduleItem>{};
          for (var item in customerItems) {
            final key = '${item.name}_${item.machineId}_${item.time}_${item.category}';
            uniqueItems[key] = item;
          }

          final sortedItems = uniqueItems.values.toList();
          // Sort items by date
          sortedItems.sort((a, b) => (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));
          return sortedItems;
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
