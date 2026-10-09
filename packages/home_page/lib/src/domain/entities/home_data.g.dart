// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpiryItemImpl _$$ExpiryItemImplFromJson(Map<String, dynamic> json) =>
    _$ExpiryItemImpl(
      customerName: json['customerName'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
      type: json['type'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      daysLeft: (json['daysLeft'] as num?)?.toInt() ?? 0,
      serviceType: json['serviceType'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
    );

Map<String, dynamic> _$$ExpiryItemImplToJson(_$ExpiryItemImpl instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'customerId': instance.customerId,
      'type': instance.type,
      'expiryDate': instance.expiryDate,
      'phone': instance.phone,
      'daysLeft': instance.daysLeft,
      'serviceType': instance.serviceType,
      'duration': instance.duration,
    };

_$PendingPaymentItemImpl _$$PendingPaymentItemImplFromJson(
  Map<String, dynamic> json,
) => _$PendingPaymentItemImpl(
  customerName: json['customerName'] as String? ?? '',
  customerId: json['customerId'] as String? ?? '',
  amountPending: (json['amountPending'] as num?)?.toDouble() ?? 0.0,
  phone: json['phone'] as String? ?? '',
  daysOverdue: (json['daysOverdue'] as num?)?.toInt() ?? 0,
  dueDate: json['dueDate'] as String? ?? '',
  type: json['type'] as String? ?? '',
);

Map<String, dynamic> _$$PendingPaymentItemImplToJson(
  _$PendingPaymentItemImpl instance,
) => <String, dynamic>{
  'customerName': instance.customerName,
  'customerId': instance.customerId,
  'amountPending': instance.amountPending,
  'phone': instance.phone,
  'daysOverdue': instance.daysOverdue,
  'dueDate': instance.dueDate,
  'type': instance.type,
};

_$ScheduleItemImpl _$$ScheduleItemImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleItemImpl(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      time: json['time'] as String? ?? '',
      isUrgent: json['isUrgent'] as bool? ?? false,
      phone: json['phone'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
    );

Map<String, dynamic> _$$ScheduleItemImplToJson(_$ScheduleItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'time': instance.time,
      'isUrgent': instance.isUrgent,
      'phone': instance.phone,
      'customerId': instance.customerId,
    };

_$ComplaintItemImpl _$$ComplaintItemImplFromJson(Map<String, dynamic> json) =>
    _$ComplaintItemImpl(
      customerName: json['customerName'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
      issueType: json['issueType'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$$ComplaintItemImplToJson(_$ComplaintItemImpl instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'customerId': instance.customerId,
      'issueType': instance.issueType,
      'status': instance.status,
    };

_$AmcProgressImpl _$$AmcProgressImplFromJson(Map<String, dynamic> json) =>
    _$AmcProgressImpl(
      companyName: json['companyName'] as String? ?? '',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      statusText: json['statusText'] as String? ?? '',
      isUrgent: json['isUrgent'] as bool? ?? false,
    );

Map<String, dynamic> _$$AmcProgressImplToJson(_$AmcProgressImpl instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'progress': instance.progress,
      'statusText': instance.statusText,
      'isUrgent': instance.isUrgent,
    };

_$NotificationItemImpl _$$NotificationItemImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationItemImpl(
  customerName: json['customerName'] as String? ?? '',
  customerId: json['customerId'] as String? ?? '',
  address: json['address'] as String? ?? '',
  serviceType: json['serviceType'] as String? ?? '',
  serviceId: json['serviceId'] as String? ?? '',
  notificationDate: json['notificationDate'] as String? ?? '',
  isDismissed: json['isDismissed'] as bool? ?? false,
  phone: json['phone'] as String? ?? '',
  note: json['note'] as String? ?? '',
  amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
  serviceDate: json['serviceDate'] as String? ?? '',
);

Map<String, dynamic> _$$NotificationItemImplToJson(
  _$NotificationItemImpl instance,
) => <String, dynamic>{
  'customerName': instance.customerName,
  'customerId': instance.customerId,
  'address': instance.address,
  'serviceType': instance.serviceType,
  'serviceId': instance.serviceId,
  'notificationDate': instance.notificationDate,
  'isDismissed': instance.isDismissed,
  'phone': instance.phone,
  'note': instance.note,
  'amount': instance.amount,
  'serviceDate': instance.serviceDate,
};

_$PendingServiceItemImpl _$$PendingServiceItemImplFromJson(
  Map<String, dynamic> json,
) => _$PendingServiceItemImpl(
  id: json['id'] as String? ?? '',
  customerId: json['customerId'] as String? ?? '',
  customerName: json['customerName'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  address: json['address'] as String? ?? '',
  serviceType: json['serviceType'] as String? ?? '',
  serviceDate: json['serviceDate'] as String? ?? '',
  status: json['status'] as String? ?? '',
  note: json['note'] as String? ?? '',
  isComplaint: json['isComplaint'] as bool? ?? false,
  amountPending: (json['amountPending'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$PendingServiceItemImplToJson(
  _$PendingServiceItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'customerName': instance.customerName,
  'phone': instance.phone,
  'address': instance.address,
  'serviceType': instance.serviceType,
  'serviceDate': instance.serviceDate,
  'status': instance.status,
  'note': instance.note,
  'isComplaint': instance.isComplaint,
  'amountPending': instance.amountPending,
};

_$HomeDataImpl _$$HomeDataImplFromJson(
  Map<String, dynamic> json,
) => _$HomeDataImpl(
  newSells: (json['newSells'] as num?)?.toInt() ?? 0,
  activeRentals: (json['activeRentals'] as num?)?.toInt() ?? 0,
  activeAmcs: (json['activeAmcs'] as num?)?.toInt() ?? 0,
  totalServices: (json['totalServices'] as num?)?.toInt() ?? 0,
  totalCollectedThisMonth:
      (json['totalCollectedThisMonth'] as num?)?.toDouble() ?? 0.0,
  amcServices: (json['amcServices'] as num?)?.toInt() ?? 0,
  newRoServices: (json['newRoServices'] as num?)?.toInt() ?? 0,
  repairServices: (json['repairServices'] as num?)?.toInt() ?? 0,
  resolutionRatePercent: (json['resolutionRatePercent'] as num?)?.toInt() ?? 0,
  pendingComplaintsCount:
      (json['pendingComplaintsCount'] as num?)?.toInt() ?? 0,
  todaySchedules:
      (json['todaySchedules'] as List<dynamic>?)
          ?.map((e) => ScheduleItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pendingComplaints:
      (json['pendingComplaints'] as List<dynamic>?)
          ?.map((e) => ComplaintItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  amcProgresses:
      (json['amcProgresses'] as List<dynamic>?)
          ?.map((e) => AmcProgress.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  todayNotifications:
      (json['todayNotifications'] as List<dynamic>?)
          ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pendingServices:
      (json['pendingServices'] as List<dynamic>?)
          ?.map((e) => PendingServiceItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  expiringItems:
      (json['expiringItems'] as List<dynamic>?)
          ?.map((e) => ExpiryItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pendingPayments:
      (json['pendingPayments'] as List<dynamic>?)
          ?.map((e) => PendingPaymentItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  todaySellsSummary: (json['todaySellsSummary'] as num?)?.toInt() ?? 0,
  weekSellsSummary: (json['weekSellsSummary'] as num?)?.toInt() ?? 0,
  projectedGrowth: json['projectedGrowth'] as String? ?? '',
);

Map<String, dynamic> _$$HomeDataImplToJson(_$HomeDataImpl instance) =>
    <String, dynamic>{
      'newSells': instance.newSells,
      'activeRentals': instance.activeRentals,
      'activeAmcs': instance.activeAmcs,
      'totalServices': instance.totalServices,
      'totalCollectedThisMonth': instance.totalCollectedThisMonth,
      'amcServices': instance.amcServices,
      'newRoServices': instance.newRoServices,
      'repairServices': instance.repairServices,
      'resolutionRatePercent': instance.resolutionRatePercent,
      'pendingComplaintsCount': instance.pendingComplaintsCount,
      'todaySchedules': instance.todaySchedules,
      'pendingComplaints': instance.pendingComplaints,
      'amcProgresses': instance.amcProgresses,
      'todayNotifications': instance.todayNotifications,
      'pendingServices': instance.pendingServices,
      'expiringItems': instance.expiringItems,
      'pendingPayments': instance.pendingPayments,
      'todaySellsSummary': instance.todaySellsSummary,
      'weekSellsSummary': instance.weekSellsSummary,
      'projectedGrowth': instance.projectedGrowth,
    };
