import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_data.freezed.dart';

@freezed
class ExpiryItem with _$ExpiryItem {
  const ExpiryItem._();

  const factory ExpiryItem({
    required String customerName,
    required String customerId,
    required String type, // 'Service' or 'Guarantee'
    required String expiryDate,
    required String phone,
  }) = _ExpiryItem;

  factory ExpiryItem.fromMap(Map<String, dynamic> map) {
    return ExpiryItem(
      customerName: map['customerName'] as String? ?? '',
      customerId: map['customerId'] as String? ?? '',
      type: map['type'] as String? ?? '',
      expiryDate: map['expiryDate'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerId': customerId,
      'type': type,
      'expiryDate': expiryDate,
      'phone': phone,
    };
  }
}

@freezed
class PendingPaymentItem with _$PendingPaymentItem {
  const PendingPaymentItem._();

  const factory PendingPaymentItem({
    required String customerName,
    required String customerId,
    required double amountPending,
    required String phone,
  }) = _PendingPaymentItem;

  factory PendingPaymentItem.fromMap(Map<String, dynamic> map) {
    return PendingPaymentItem(
      customerName: map['customerName'] as String? ?? '',
      customerId: map['customerId'] as String? ?? '',
      amountPending: (map['amountPending'] as num?)?.toDouble() ?? 0.0,
      phone: map['phone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerId': customerId,
      'amountPending': amountPending,
      'phone': phone,
    };
  }
}

@freezed
class ScheduleItem with _$ScheduleItem {
  const ScheduleItem._();

  const factory ScheduleItem({
    required String title,
    required String subtitle,
    required String time,
    @Default(false) bool isUrgent,
    @Default('') String phone,
    @Default('') String customerId,
  }) = _ScheduleItem;

  factory ScheduleItem.fromMap(Map<String, dynamic> map) {
    return ScheduleItem(
      title: map['title'] as String? ?? '',
      subtitle: map['subtitle'] as String? ?? '',
      time: map['time'] as String? ?? '',
      isUrgent: map['isUrgent'] as bool? ?? false,
      phone: map['phone'] as String? ?? '',
      customerId: map['customerId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'time': time,
      'isUrgent': isUrgent,
      'phone': phone,
      'customerId': customerId,
    };
  }
}

@freezed
class ComplaintItem with _$ComplaintItem {
  const ComplaintItem._();

  const factory ComplaintItem({
    required String customerName,
    required String customerId,
    required String issueType,
    required String status,
  }) = _ComplaintItem;

  factory ComplaintItem.fromMap(Map<String, dynamic> map) {
    return ComplaintItem(
      customerName: map['customerName'] as String? ?? '',
      customerId: map['customerId'] as String? ?? '',
      issueType: map['issueType'] as String? ?? '',
      status: map['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerId': customerId,
      'issueType': issueType,
      'status': status,
    };
  }
}

@freezed
class AmcProgress with _$AmcProgress {
  const AmcProgress._();

  const factory AmcProgress({
    required String companyName,
    required double progress,
    required String statusText,
    @Default(false) bool isUrgent,
  }) = _AmcProgress;

  factory AmcProgress.fromMap(Map<String, dynamic> map) {
    return AmcProgress(
      companyName: map['companyName'] as String? ?? '',
      progress: (map['progress'] as num?)?.toDouble() ?? 0.0,
      statusText: map['statusText'] as String? ?? '',
      isUrgent: map['isUrgent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'progress': progress,
      'statusText': statusText,
      'isUrgent': isUrgent,
    };
  }
}

@freezed
class NotificationItem with _$NotificationItem {
  const NotificationItem._();

  const factory NotificationItem({
    required String customerName,
    required String customerId,
    required String address,
    required String serviceType,
    required String serviceId,
    required String notificationDate,
    @Default(false) bool isDismissed,
    @Default('') String phone,
  }) = _NotificationItem;

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
      customerName: map['customerName'] as String? ?? '',
      customerId: map['customerId'] as String? ?? '',
      address: map['address'] as String? ?? '',
      serviceType: map['serviceType'] as String? ?? '',
      serviceId: map['serviceId'] as String? ?? '',
      notificationDate: map['notificationDate'] as String? ?? '',
      isDismissed: map['isDismissed'] as bool? ?? false,
      phone: map['phone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerId': customerId,
      'address': address,
      'serviceType': serviceType,
      'serviceId': serviceId,
      'notificationDate': notificationDate,
      'isDismissed': isDismissed,
      'phone': phone,
    };
  }
}

@freezed
class HomeData with _$HomeData {
  const HomeData._();

  const factory HomeData({
    required int newSells,
    required int activeRentals,
    required int activeAmcs,
    required int totalServices,
    required double totalCollectedThisMonth,
    required int amcServices,
    required int newRoServices,
    required int repairServices,
    required int resolutionRatePercent,
    required int pendingComplaintsCount,
    required List<ScheduleItem> todaySchedules,
    required List<ComplaintItem> pendingComplaints,
    required List<AmcProgress> amcProgresses,
    required List<NotificationItem> todayNotifications,
    @Default([]) List<ExpiryItem> expiringItems,
    @Default([]) List<PendingPaymentItem> pendingPayments,
    required int todaySellsSummary,
    required int weekSellsSummary,
    required String projectedGrowth,
  }) = _HomeData;

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      newSells: map['newSells'] as int? ?? 0,
      activeRentals: map['activeRentals'] as int? ?? 0,
      activeAmcs: map['activeAmcs'] as int? ?? 0,
      totalServices: map['totalServices'] as int? ?? 0,
      totalCollectedThisMonth: (map['totalCollectedThisMonth'] as num?)?.toDouble() ?? 0.0,
      amcServices: map['amcServices'] as int? ?? 0,
      newRoServices: map['newRoServices'] as int? ?? 0,
      repairServices: map['repairServices'] as int? ?? 0,
      resolutionRatePercent: map['resolutionRatePercent'] as int? ?? 0,
      pendingComplaintsCount: map['pendingComplaintsCount'] as int? ?? 0,
      todaySchedules: (map['todaySchedules'] as List<dynamic>?)
              ?.map((e) => ScheduleItem.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      pendingComplaints: (map['pendingComplaints'] as List<dynamic>?)
              ?.map((e) => ComplaintItem.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      amcProgresses: (map['amcProgresses'] as List<dynamic>?)
              ?.map((e) => AmcProgress.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      todayNotifications: (map['todayNotifications'] as List?)
          ?.map((e) => NotificationItem.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList() ?? [],
      expiringItems: (map['expiringItems'] as List?)
          ?.map((e) => ExpiryItem.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList() ?? [],
      pendingPayments: (map['pendingPayments'] as List?)
          ?.map((e) => PendingPaymentItem.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList() ?? [],
      todaySellsSummary: map['todaySellsSummary'] as int? ?? 0,
      weekSellsSummary: map['weekSellsSummary'] as int? ?? 0,
      projectedGrowth: map['projectedGrowth'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'newSells': newSells,
      'activeRentals': activeRentals,
      'activeAmcs': activeAmcs,
      'totalServices': totalServices,
      'totalCollectedThisMonth': totalCollectedThisMonth,
      'amcServices': amcServices,
      'newRoServices': newRoServices,
      'repairServices': repairServices,
      'resolutionRatePercent': resolutionRatePercent,
      'pendingComplaintsCount': pendingComplaintsCount,
      'todaySchedules': todaySchedules.map((e) => e.toMap()).toList(),
      'pendingComplaints': pendingComplaints.map((e) => e.toMap()).toList(),
      'amcProgresses': amcProgresses.map((e) => e.toMap()).toList(),
      'todayNotifications': todayNotifications.map((e) => e.toMap()).toList(),
      'expiringItems': expiringItems.map((e) => e.toMap()).toList(),
      'pendingPayments': pendingPayments.map((e) => e.toMap()).toList(),
      'todaySellsSummary': todaySellsSummary,
      'weekSellsSummary': weekSellsSummary,
      'projectedGrowth': projectedGrowth,
    };
  }
}
