import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/repositories/home_repository_interface.dart';

class HomeRepository implements IHomeRepository {
  final FirebaseFirestore? _firestore;

  HomeRepository({FirebaseFirestore? firestore}) : _firestore = firestore;

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
  Stream<HomeData> getHomeData() {
    if (_firestore == null && Firebase.apps.isEmpty) {
      return Stream.value(_getInitialMockData());
    }

    final customersStream = firestore
        .collection('Customer')
        .snapshots();

    final servicesStream = firestore.collectionGroup('services').snapshots();
    final installmentsStream =
        firestore.collectionGroup('installments').snapshots();

    return Rx.combineLatest3(
      customersStream,
      servicesStream,
      installmentsStream,
      (
        QuerySnapshot customersSnap,
        QuerySnapshot servicesSnap,
        QuerySnapshot installmentsSnap,
      ) {
        final now = DateTime.now();
        final payload = _HomeComputePayload(
          customers: customersSnap.docs.map((d) => d.data() as Map<String, dynamic>..['id'] = d.id).toList(),
          services: servicesSnap.docs.map((d) => d.data() as Map<String, dynamic>..['id'] = d.id..['customerId'] = d.reference.parent.parent?.id ?? '').toList(),
          installments: installmentsSnap.docs.map((d) => d.data() as Map<String, dynamic>..['id'] = d.id..['customerId'] = d.reference.parent.parent?.id ?? '').toList(),
          now: now,
        );
        return _processHomeDataTask(payload);
      },
    ).handleError((error) {
      debugPrint('Firestore error in getHomeData: $error. Falling back to mock.');
      return _getInitialMockData();
    });
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
              ),
            );
          }
        } catch (_) {}
      }
    }
  }

  List<PendingServiceItem> pendingServices = [];

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
        ),
      );
    }

    if (serviceExpiry != null) {
      final diff = serviceExpiry.difference(now).inDays;
      if (diff <= 7 && diff >= -30) {
        expiringItems.add(
          ExpiryItem(
            customerName: customerName,
            customerId: custId,
            type: 'Service',
            expiryDate: serviceExpiry.toIso8601String().split('T')[0],
            phone: phone,
          ),
        );
      }
    }

    if (guaranteeExpiry != null) {
      final diff = guaranteeExpiry.difference(now).inDays;
      if (diff <= 7 && diff >= -30) {
        expiringItems.add(
          ExpiryItem(
            customerName: customerName,
            customerId: custId,
            type: 'Guarantee',
            expiryDate: guaranteeExpiry.toIso8601String().split('T')[0],
            phone: phone,
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
        ),
      );
    }

    if (status == 'pending') {
       pendingComplaints.add(
         ComplaintItem(
           customerName: customerName,
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
       pendingServices.add(PendingServiceItem(
         id: data['id'],
         customerId: custId,
         customerName: customerName,
         phone: phone,
         address: custData?['address'] ?? '',
         serviceType: data['serviceType'] ?? data['service_type'] ?? '',
         serviceDate: date,
         status: status.isEmpty ? 'pending' : status,
       ));
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
