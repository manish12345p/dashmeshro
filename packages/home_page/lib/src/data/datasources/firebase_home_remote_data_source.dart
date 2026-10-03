import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/home_data.dart';
import 'home_remote_data_source.dart';
import 'package:core/core.dart';

class FirebaseHomeRemoteDataSource implements IHomeRemoteDataSource {
  final FirebaseFirestore? _firestore;

  FirebaseHomeRemoteDataSource({FirebaseFirestore? firestore}) : _firestore = firestore;

  FirebaseFirestore get firestore => _firestore ?? FirebaseFirestore.instance;

  DateTime? _calculateExpiry(String dateStr, String durationStr) {
    if (dateStr.isEmpty || durationStr.isEmpty) return null;
    try {
      final date = DateTime.parse(dateStr);
      final parts = durationStr.split(' ');
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
  Stream<HomeData> getHomeData() async* {
    if (_firestore == null && Firebase.apps.isEmpty) {
      yield _getInitialMockData();
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString('cached_home_data');
      if (cachedJson != null) {
        final decoded = json.decode(cachedJson) as Map<String, dynamic>;
        yield HomeData.fromJson(decoded);
      }
    } catch (e) {
      debugPrint('Failed to load cached home data: $e');
    }

    final Map<String, Map<String, dynamic>> cachedCustomers = {};
    final Map<String, Map<String, dynamic>> cachedServices = {};
    final Map<String, Map<String, dynamic>> cachedInstallments = {};

    final controller = StreamController<HomeData>();
    
    void triggerUpdate() {
      final payload = _HomeComputePayload(
        customers: cachedCustomers.values.toList(),
        services: cachedServices.values.toList(),
        installments: cachedInstallments.values.toList(),
        now: DateTime.now(),
      );
      
      final data = _processHomeDataTask(payload);
      
      try {
         SharedPreferences.getInstance().then((prefs) {
           prefs.setString('cached_home_data', json.encode(data.toJson()));
         });
      } catch (_) {}
      
      if (!controller.isClosed) {
        controller.add(data);
      }
    }
    
    final debouncer = PublishSubject<void>();
    final sub = debouncer.debounceTime(const Duration(milliseconds: 500)).listen((_) {
      triggerUpdate();
    });

    final sub1 = firestore.collection('Customer').snapshots().listen((snap) {
      for (var change in snap.docChanges) {
        if (change.type == DocumentChangeType.removed) {
          cachedCustomers.remove(change.doc.id);
        } else {
          final data = change.doc.data() ?? {};
          cachedCustomers[change.doc.id] = {
            'id': change.doc.id,
            'name': data['name'],
            'number': data['number'],
            'address': data['address'],
            'ro_type': data['ro_type'],
            'created_at': data['createdAt'] ?? data['created_at'],
            'lastDismissedReminder': data['lastDismissedReminder'],
          };
        }
      }
      debouncer.add(null);
    }, onError: (e) {
       debugPrint('Error loading customers: $e');
    });

    final sub2 = firestore.collectionGroup('services').snapshots().listen((snap) {
      for (var change in snap.docChanges) {
        if (change.type == DocumentChangeType.removed) {
          cachedServices.remove(change.doc.id);
        } else {
          final data = change.doc.data() ?? {};
          data['id'] = change.doc.id;
          data['customerId'] = change.doc.reference.parent.parent?.id ?? '';
          cachedServices[change.doc.id] = data;
        }
      }
      debouncer.add(null);
    }, onError: (e) {
       debugPrint('Error loading services: $e');
    });

    final sub3 = firestore.collectionGroup('installments').snapshots().listen((snap) {
      for (var change in snap.docChanges) {
        if (change.type == DocumentChangeType.removed) {
          cachedInstallments.remove(change.doc.id);
        } else {
          final data = change.doc.data() ?? {};
          data['id'] = change.doc.id;
          data['customerId'] = change.doc.reference.parent.parent?.id ?? '';
          cachedInstallments[change.doc.id] = data;
        }
      }
      debouncer.add(null);
    }, onError: (e) {
       debugPrint('Error loading installments: $e');
    });
    
    controller.onCancel = () {
      sub1.cancel();
      sub2.cancel();
      sub3.cancel();
      sub.cancel();
      debouncer.close();
    };
    
    yield* controller.stream;
  }

  HomeData _getInitialMockData() {
    return const HomeData(
      newSells: 0,
      activeRentals: 0,
      activeAmcs: 0,
      totalServices: 0,
      totalCollectedThisMonth: 0.0,
      amcServices: 0,
      newRoServices: 0,
      repairServices: 0,
      resolutionRatePercent: 100,
      pendingComplaintsCount: 0,
      todaySchedules: [],
      pendingComplaints: [],
      amcProgresses: [],
      todayNotifications: [],
      expiringItems: [],
      pendingPayments: [],
      todaySellsSummary: 0,
      weekSellsSummary: 0,
      projectedGrowth: '+0% vs LW',
    );
  }

  @override
  Future<void> createHomeData(HomeData data) async {}

  @override
  Future<void> updateHomeData(HomeData data) async {}

  @override
  Future<void> deleteHomeData(String id) async {}
}

class _HomeComputePayload {
  final List<Map<String, dynamic>> customers;
  final List<Map<String, dynamic>> services;
  final List<Map<String, dynamic>> installments;
  final DateTime now;

  _HomeComputePayload({
    required this.customers,
    required this.services,
    required this.installments,
    required this.now,
  });
}

DateTime? _calculateExpiryLocal(String dateStr, String durationStr) {
  if (dateStr.isEmpty || durationStr.isEmpty) return null;
  try {
    final date = DateTime.parse(dateStr);
    final parts = durationStr.split(' ');
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

HomeData _processHomeDataTask(_HomeComputePayload payload) {
  final now = payload.now;
  final todayStr = now.toIso8601String().split('T')[0];
  final currentMonthStr = '${now.year}-${now.month.toString().padLeft(2, '0')}';

  Map<String, Map<String, dynamic>> customerDataById = {};
  for (var data in payload.customers) {
    customerDataById[data['id']] = data;
  }

  int activeAmcs = 0;
  int activeRentals = 0;
  int newSells = 0;
  List<AmcProgress> progresses = [];

  for (var data in customerDataById.values) {
    final roType = (data['ro_type'] as String? ?? '').toLowerCase();
    if (roType.contains('amc')) {
      activeAmcs++;
    }
  }

  int pendingComplaintsCount = 0;
  int totalServicesCount = 0;
  int amcServicesCount = 0;
  int newRoServicesCount = 0;
  int repairServicesCount = 0;

  int todayNewSells = 0;
  int weekNewSells = 0;
  int lastWeekNewSells = 0;

  List<ScheduleItem> todaySchedules = [];
  List<ComplaintItem> pendingComplaints = [];

  double totalCollectedThisMonth = 0.0;
  List<NotificationItem> todayNotifications = [];
  List<ExpiryItem> expiringItems = [];
  List<PendingPaymentItem> pendingPayments = [];
  List<PendingServiceItem> pendingServices = [];
  Set<String> customersWithExplicitServiceDue = {};

  // 1. Calculate the base service date (latest service) for each customer
  Map<String, DateTime> latestServiceDates = {};
  for (var data in payload.services) {
    if (data['isDeleted'] == true) continue;
    final custId = data['customerId'] as String;
    final dateStr = data['serviceDate'] as String? ?? data['service_date'] as String? ?? '';
    if (dateStr.isNotEmpty) {
      try {
        final date = DateTime.parse(dateStr);
        if (!latestServiceDates.containsKey(custId) || date.isAfter(latestServiceDates[custId]!)) {
          latestServiceDates[custId] = date;
        }
      } catch (_) {}
    }
  }

  // 2. Generate 3-month recurring reminders for all customers
  for (var custData in customerDataById.values) {
    final custId = custData['id'] as String;
    DateTime baseDate;
    
    if (latestServiceDates.containsKey(custId)) {
      baseDate = latestServiceDates[custId]!;
    } else {
      // Fallback to customer creation date, or if not present, today
      final createdAtStr = custData['created_at'];
      if (createdAtStr != null && createdAtStr is String && createdAtStr.isNotEmpty) {
        baseDate = DateTime.tryParse(createdAtStr) ?? now;
      } else if (createdAtStr != null && createdAtStr is Timestamp) {
        baseDate = createdAtStr.toDate();
      } else {
        baseDate = now;
      }
    }

    final nextReminderDate = ReminderUtils.getNextOrOverdueReminder(baseDate);
    final isToday = nextReminderDate.year == now.year && 
                    nextReminderDate.month == now.month && 
                    nextReminderDate.day == now.day;
    final diffDays = nextReminderDate.difference(DateTime(now.year, now.month, now.day)).inDays;
    final isOverdue = diffDays < 0 && diffDays >= -3; // Max 3 days overdue

    final lastDismissedStr = custData['lastDismissedReminder'] as String?;
    bool isDismissed = false;
    if (lastDismissedStr != null && lastDismissedStr.isNotEmpty) {
      try {
        final lastDismissedDate = DateTime.parse(lastDismissedStr);
        // Compare dates ignoring time
        final dismissDay = DateTime(lastDismissedDate.year, lastDismissedDate.month, lastDismissedDate.day);
        final reminderDay = DateTime(nextReminderDate.year, nextReminderDate.month, nextReminderDate.day);
        if (reminderDay.isBefore(dismissDay) || reminderDay.isAtSameMomentAs(dismissDay)) {
          isDismissed = true;
        }
      } catch (_) {}
    }

    final customerName = custData['name'] as String? ?? 'Unknown';
    final phone = custData['number'] as String? ?? '';
    final address = custData['address'] as String? ?? '';

    // If reminder is today, add to Today's Visit Schedule
    if (isToday) {
      if (todaySchedules.length < 5) { // Just limiting to 5 for the UI card summary
        todaySchedules.add(
          ScheduleItem(
            title: '3-Month Service - $customerName',
            subtitle: 'Routine Maintenance',
            time: 'Due Today',
            isUrgent: false,
          ),
        );
      }
    }

    // If reminder is today OR overdue, add to Notifications
    if (isToday || isOverdue) {
      final statusLabel = isOverdue ? 'Overdue Service' : 'Service Due';
      final formattedDate = nextReminderDate.toIso8601String().split('T')[0];
      
      todayNotifications.add(
        NotificationItem(
          customerName: customerName,
          customerId: custId,
          address: address,
          serviceType: '3-Month Recurring Service',
          serviceId: 'reminder_${nextReminderDate.millisecondsSinceEpoch}',
          notificationDate: formattedDate,
          isDismissed: isDismissed,
          phone: phone,
          note: statusLabel,
          amount: 0.0,
          serviceDate: formattedDate,
        ),
      );
    }
  }

  // Process Rent installments
  for (var idata in payload.installments) {
    final custId = idata['customerId'] as String;
    final custData = customerDataById[custId];

    // Skip orphaned installments
    if (custData == null) continue;

    final isRent = idata['isRent'] as bool? ?? false;
    final status = idata['status'] as String? ?? 'pending';
    final dueDateStr = idata['dueDate'] as String? ?? '';
    
    final customerName = custData['name'] as String? ?? 'Unknown';
    final phone = custData['number'] as String? ?? '';

    if (isRent && (status == 'pending' || status == 'overdue')) {
      if (dueDateStr.isNotEmpty) {
        try {
          final dueDate = DateTime.parse(dueDateStr);
          if (dueDate.year == now.year &&
              dueDate.month == now.month &&
              (dueDate.isBefore(now) || dueDateStr.startsWith(todayStr))) {
            todayNotifications.add(
              NotificationItem(
                customerName: customerName,
                customerId: custId,
                address: custData?['address'] as String? ?? '',
                serviceType: 'Rent Due',
                serviceId: idata['id'],
                notificationDate: dueDateStr,
                isDismissed: false,
                phone: phone,
                note: idata['remarks'] as String? ?? '',
                amount: (idata['totalAmount'] as num? ?? idata['amountPaid'] as num? ?? 0.0).toDouble(),
                serviceDate: idata['serviceDate'] as String? ?? idata['service_date'] as String? ?? '',
              ),
            );
          }
          final diff = dueDate.difference(now).inDays;
          // Include overdue up to 30 days ago, or due within 7 days
          if (diff <= 7 && diff >= -30) {
            pendingPayments.add(
              PendingPaymentItem(
                customerName: customerName,
                customerId: custId,
                amountPending: (idata['totalAmount'] as num? ?? idata['amountPaid'] as num? ?? 0.0).toDouble(),
                phone: phone,
                daysOverdue: -diff, // if diff is negative, it's overdue
                dueDate: dueDateStr,
                type: 'Rent',
              ),
            );
          }
        } catch (_) {}
      }
    }
  }

  for (var data in payload.services) {
    // Skip deleted services
    if (data['isDeleted'] == true) continue;

    final custId = data['customerId'] as String;
    final custData = customerDataById[custId];

    // Skip orphaned services (where parent customer is deleted/missing)
    if (custData == null) continue;
    
    final type = (data['serviceType'] as String? ?? data['service_type'] as String? ?? '').toLowerCase().trim();
    final status = data['status'] as String? ?? '';
    final date = data['serviceDate'] as String? ?? data['service_date'] as String? ?? '';

    if (date.startsWith(currentMonthStr)) {
      totalCollectedThisMonth += (data['amountPaid'] as num? ?? 0.0).toDouble();
    }

    totalServicesCount++;
    
    if (type.contains('amc')) {
      amcServicesCount++;
    } else if (type.contains('new ro')) {
      newRoServicesCount++;

      if (date.startsWith(todayStr)) {
        todayNewSells++;
      }
      if (date.isNotEmpty) {
        try {
          final serviceDate = DateTime.parse(date);
          final daysDifference = now.difference(serviceDate).inDays;
          if (daysDifference >= 0 && daysDifference <= 7) {
            weekNewSells++;
          } else if (daysDifference > 7 && daysDifference <= 14) {
            lastWeekNewSells++;
          }
        } catch (_) {}
      }
    } else if (type.contains('service') || type.contains('repair')) {
      repairServicesCount++;
    }

    final serviceDuration = data['serviceDuration'] as String? ?? '';
    final guaranteeDuration = data['guaranteeDuration'] as String? ?? '';
    final serviceExpiry = _calculateExpiryLocal(date, serviceDuration);
    final guaranteeExpiry = _calculateExpiryLocal(date, guaranteeDuration);

    final customerName = custData?['name'] as String? ?? data['customer_name'] as String? ?? 'Unknown';
    final phone = custData?['number'] as String? ?? data['customer_phone'] as String? ?? '';

    if (date == todayStr || status == 'in_progress') {
      if (todaySchedules.length < 5) {
        final dueTimeStr = serviceExpiry != null 
            ? 'Due: ${serviceExpiry.day.toString().padLeft(2, '0')}/${serviceExpiry.month.toString().padLeft(2, '0')}/${serviceExpiry.year}' 
            : date;
        todaySchedules.add(
          ScheduleItem(
            title: '${data['serviceType']} - $customerName',
            subtitle: data['remarks'] as String? ?? 'No remarks',
            time: dueTimeStr,
            isUrgent: status == 'in_progress',
          ),
        );
      }
    }

    if (serviceExpiry != null &&
        serviceExpiry.year == now.year &&
        serviceExpiry.month == now.month &&
        serviceExpiry.day == now.day) {
      final serviceLabel = '${data['serviceType'] as String? ?? 'Service'}${serviceDuration.isNotEmpty ? ' · Due: ${serviceExpiry.day.toString().padLeft(2, '0')}/${serviceExpiry.month.toString().padLeft(2, '0')}/${serviceExpiry.year}' : ''}';
      todayNotifications.add(
        NotificationItem(
          customerName: customerName,
          customerId: custId,
          address: custData?['address'] as String? ?? '',
          serviceType: serviceLabel,
          serviceId: data['id'],
          notificationDate: serviceExpiry.toIso8601String().split('T')[0],
          isDismissed: data['isDismissed'] as bool? ?? false,
          phone: phone,
          note: data['fixes'] as String? ?? '',
          amount: (data['totalAmount'] as num? ?? data['amountPaid'] as num? ?? 0.0).toDouble(),
          serviceDate: date,
        ),
      );
    }

    if (serviceExpiry != null) {
      final diff = serviceExpiry.difference(now).inDays;
      if (diff <= 7 && diff >= -30) {
        expiringItems.add(
          ExpiryItem(
            customerName: custData?['name'] as String? ?? 'Unknown',
            customerId: custId,
            type: 'Service',
            expiryDate: serviceExpiry.toIso8601String().split('T')[0],
            phone: custData?['number'] as String? ?? '',
            daysLeft: diff,
            serviceType: type,
            duration: serviceDuration,
          ),
        );
        customersWithExplicitServiceDue.add(custId);
      }
    }

    if (guaranteeExpiry != null) {
      final diff = guaranteeExpiry.difference(now).inDays;
      if (diff <= 7 && diff >= -30) {
        expiringItems.add(
          ExpiryItem(
            customerName: custData?['name'] as String? ?? 'Unknown',
            customerId: custId,
            type: 'Guarantee',
            expiryDate: guaranteeExpiry.toIso8601String().split('T')[0],
            phone: custData?['number'] as String? ?? '',
            daysLeft: diff,
            serviceType: type,
            duration: guaranteeDuration,
          ),
        );
      }
    }

    final amountPending = (data['amountPending'] ?? data['amount_pending'] ?? 0.0) as num;
    if (amountPending > 0) {
      pendingPayments.add(
        PendingPaymentItem(
          customerName: customerName,
          customerId: custId,
          amountPending: amountPending.toDouble(),
          phone: phone,
          daysOverdue: 0,
          dueDate: date,
          type: 'Service Payment',
        ),
      );
    }

    // Process pending complaints and services
    if (status == 'pending' && type.contains('complaint')) {
       pendingComplaintsCount++;
       pendingComplaints.add(
         ComplaintItem(
           customerName: custData['name'] as String? ?? 'Unknown',
           customerId: custId,
           issueType: type,
           status: 'pending',
         )
       );
    }
    
    // Check for pending services explicitly
    bool isPending = false;
    if (status == 'pending') {
      isPending = true;
    } else if (status.isEmpty && date.compareTo(todayStr) >= 0) {
      isPending = true;
    } else if (status == 'completed') {
      final completedAtStr = data['completedAt'] as String?;
      if (completedAtStr != null) {
        final completedAt = DateTime.tryParse(completedAtStr);
        if (completedAt != null && now.difference(completedAt).inHours < 24) {
           isPending = true;
        }
      }
    }

    if (isPending) {
        pendingServices.add(
          PendingServiceItem(
            id: data['id'],
            customerId: custId,
            customerName: custData['name'] as String? ?? 'Unknown',
            phone: custData['number'] as String? ?? '',
            address: custData['address'] as String? ?? '',
            serviceType: type,
            serviceDate: date,
            status: status,
            note: data['fixes'] as String? ?? '',
            isComplaint: type.contains('complaint'),
          ),
        ); 
        customersWithExplicitServiceDue.add(custId);
    } 
  }

  // 2. Generate 3-month recurring reminders for all customers
  for (var custData in customerDataById.values) {
    final custId = custData['id'] as String;
    
    // Skip auto-reminder if customer already has an explicit pending service or service expiry due
    if (customersWithExplicitServiceDue.contains(custId)) continue;

    DateTime baseDate;
    
    if (latestServiceDates.containsKey(custId)) {
      baseDate = latestServiceDates[custId]!;
    } else {
      // Fallback to customer creation date, or if not present, today
      final createdAtStr = custData['created_at'];
      if (createdAtStr != null && createdAtStr is String && createdAtStr.isNotEmpty) {
        baseDate = DateTime.tryParse(createdAtStr) ?? now;
      } else if (createdAtStr != null && createdAtStr is Timestamp) {
        baseDate = createdAtStr.toDate();
      } else {
        baseDate = now;
      }
    }

    final nextReminderDate = ReminderUtils.getNextOrOverdueReminder(baseDate);
    final isToday = nextReminderDate.year == now.year && 
                    nextReminderDate.month == now.month && 
                    nextReminderDate.day == now.day;
    final diffDays = nextReminderDate.difference(DateTime(now.year, now.month, now.day)).inDays;
    final isOverdue = diffDays < 0 && diffDays >= -7; // Max 7 days overdue

    if (isToday || isOverdue) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(nextReminderDate);
      todaySchedules.add(
        ScheduleItem(
          title: custData['name'] as String? ?? 'Unknown',
          subtitle: '3-Month Recurring Service',
          time: isOverdue ? 'Overdue' : 'Today',
          isUrgent: isOverdue,
          phone: custData['number'] as String? ?? '',
          customerId: custId,
        ),
      );
    }
  }

  String growthText = '0% vs LW';
  if (lastWeekNewSells > 0) {
    final growth = ((weekNewSells - lastWeekNewSells) / lastWeekNewSells) * 100;
    growthText = '${growth >= 0 ? '+' : ''}${growth.round()}% vs LW';
  } else if (weekNewSells > 0) {
    growthText = '+100% vs LW';
  }

  return HomeData(
    newSells: newSells,
    activeRentals: activeRentals,
    activeAmcs: activeAmcs,
    totalServices: totalServicesCount,
    totalCollectedThisMonth: totalCollectedThisMonth,
    amcServices: amcServicesCount,
    newRoServices: newRoServicesCount,
    repairServices: repairServicesCount,
    resolutionRatePercent: 100,
    pendingComplaintsCount: pendingComplaintsCount,
    todaySchedules: todaySchedules,
    pendingComplaints: pendingComplaints,
    pendingServices: pendingServices,
    amcProgresses: progresses,
    todayNotifications: todayNotifications,
    expiringItems: expiringItems,
    pendingPayments: pendingPayments,
    todaySellsSummary: todayNewSells,
    weekSellsSummary: weekNewSells,
    projectedGrowth: growthText,
  );
}
