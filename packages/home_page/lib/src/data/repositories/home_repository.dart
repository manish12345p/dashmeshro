import 'dart:async';
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
        .where('is_deleted', isEqualTo: false)
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
        // 1. Process Customers
        Map<String, Map<String, dynamic>> customerDataById = {};
        for (var doc in customersSnap.docs) {
          customerDataById[doc.id] = doc.data() as Map<String, dynamic>;
        }

        int activeAmcs = 0;
        int activeRentals = 0;
        int newSells = 0;
        List<AmcProgress> progresses = [];

        // In the Excel data, customer type logic relies more on service types now
        // But we can check 'ro_type' just in case.
        for (var doc in customersSnap.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final roType = (data['ro_type'] as String? ?? '').toLowerCase();
          
          if (roType.contains('amc')) {
             activeAmcs++;
          }
        }

        // 2. Process Service Entries
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

        final now = DateTime.now();
        final todayStr = now.toIso8601String().split('T')[0];
        final currentMonthStr =
            '${now.year}-${now.month.toString().padLeft(2, '0')}';

        double totalCollectedThisMonth = 0.0;
        List<NotificationItem> todayNotifications = [];
        List<ExpiryItem> expiringItems = [];
        List<PendingPaymentItem> pendingPayments = [];

        // Process Rent installments
        for (var idoc in installmentsSnap.docs) {
          final idata = idoc.data() as Map<String, dynamic>;
          final isRent = idata['isRent'] as bool? ?? false;
          final status = idata['status'] as String? ?? 'pending';
          final dueDateStr = idata['dueDate'] as String? ?? '';
          
          // Determine parent customer ID by stripping the last segment of the path
          // Document path is like: Customer/{customerId}/installments/{installmentId}
          final custId = idoc.reference.parent.parent?.id ?? '';
          
          final custData = customerDataById[custId];
          final customerName = custData?['name'] as String? ?? 'Unknown';
          final phone = custData?['number'] as String? ?? '';

          if (isRent && (status == 'pending' || status == 'overdue')) {
            if (dueDateStr.isNotEmpty) {
              try {
                final dueDate = DateTime.parse(dueDateStr);
                if (dueDate.year == now.year &&
                    dueDate.month == now.month &&
                    (dueDate.isBefore(now) ||
                        dueDateStr.startsWith(todayStr))) {
                  todayNotifications.add(
                    NotificationItem(
                      customerName: customerName,
                      customerId: custId,
                      address: custData?['address'] as String? ?? '',
                      serviceType: 'Rent Due',
                      serviceId: idoc.id,
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

        for (var sdoc in servicesSnap.docs) {
          final data = sdoc.data() as Map<String, dynamic>;
          final custId = sdoc.reference.parent.parent?.id ?? '';
          final custData = customerDataById[custId];
          
          final type =
              (data['serviceType'] as String? ?? data['service_type'] as String? ?? '').toLowerCase().trim();
          final status = data['status'] as String? ?? '';
          final date =
              data['serviceDate'] as String? ?? data['service_date'] as String? ?? '';

          if (date.startsWith(currentMonthStr)) {
            totalCollectedThisMonth += (data['amountPaid'] as num? ?? 0.0).toDouble();
          }

          totalServicesCount++;
          
          // Categorize Service
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
            // Service, Repair
            repairServicesCount++;
          }

          if (date == todayStr || status == 'in_progress') {
            if (todaySchedules.length < 5) {
              todaySchedules.add(
                ScheduleItem(
                  title: '${data['serviceType']} - ${data['customer_name'] ?? custData?['name'] ?? 'Unknown'}',
                  subtitle: data['remarks'] as String? ?? 'No remarks',
                  time: date,
                  isUrgent: status == 'in_progress',
                ),
              );
            }
          }

          // Check notificationDate
          final notifDate = data['notificationDate'] as String? ?? '';
          final customerName =
              custData?['name'] as String? ??
              data['customer_name'] as String? ??
              'Unknown';
          final phone = custData?['number'] as String? ?? '';

          if (notifDate.startsWith(todayStr)) {
            todayNotifications.add(
              NotificationItem(
                customerName: customerName,
                customerId: custId,
                address: custData?['address'] as String? ?? '',
                serviceType: data['serviceType'] as String? ?? '',
                serviceId: sdoc.id,
                notificationDate: notifDate,
                isDismissed: data['isDismissed'] as bool? ?? false,
                phone: phone,
              ),
            );
          }

          // Check expiries
          final serviceDuration = data['serviceDuration'] as String? ?? '';
          final guaranteeDuration = data['guaranteeDuration'] as String? ?? '';

          final serviceExpiry = _calculateExpiry(date, serviceDuration);
          final guaranteeExpiry = _calculateExpiry(date, guaranteeDuration);

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

          final amountPending =
              (data['amountPending'] ?? data['amount_pending'] ?? 0.0) as num;
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
        }

        String growthText = '0% vs LW';
        if (lastWeekNewSells > 0) {
          final growth =
              ((weekNewSells - lastWeekNewSells) / lastWeekNewSells) * 100;
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
          amcProgresses: progresses,
          todayNotifications: todayNotifications,
          expiringItems: expiringItems,
          pendingPayments: pendingPayments,
          todaySellsSummary: todayNewSells,
          weekSellsSummary: weekNewSells,
          projectedGrowth: growthText,
        );
      },
    ).handleError((error) {
      print('Firestore error in getHomeData: $error. Falling back to mock.');
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

