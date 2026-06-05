// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceActivityImpl _$$ServiceActivityImplFromJson(
  Map<String, dynamic> json,
) => _$ServiceActivityImpl(
  id: json['id'] as String,
  serviceType: json['serviceType'] as String,
  fixes: json['fixes'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  amountPaid: (json['amountPaid'] as num).toDouble(),
  equipmentsUsed: json['equipmentsUsed'] as String,
  guaranteeDuration: json['guaranteeDuration'] as String? ?? '',
  remarks: json['remarks'] as String? ?? '',
  serviceDate: DateTime.parse(json['serviceDate'] as String),
);

Map<String, dynamic> _$$ServiceActivityImplToJson(
  _$ServiceActivityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'serviceType': instance.serviceType,
  'fixes': instance.fixes,
  'totalAmount': instance.totalAmount,
  'amountPaid': instance.amountPaid,
  'equipmentsUsed': instance.equipmentsUsed,
  'guaranteeDuration': instance.guaranteeDuration,
  'remarks': instance.remarks,
  'serviceDate': instance.serviceDate.toIso8601String(),
};

_$CustomerImpl _$$CustomerImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerImpl(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  customerId: json['customer_id'] as String,
  number: json['number'] as String,
  email: json['email'] as String? ?? '',
  address: json['address'] as String? ?? '',
  locality: json['locality'] as String? ?? '',
  roType: json['ro_type'] as String? ?? '',
  note: json['note'] as String? ?? '',
  role: json['role'] as String? ?? '',
  status: json['status'] as String? ?? 'active',
  customerType: json['customer_type'] as String? ?? 'Active AMC',
  avatarUrl: json['avatar_url'] as String? ?? '',
  deviceName: json['device_name'] as String? ?? '',
  deviceInstalledOn: json['device_installed_on'] as String? ?? '',
  deviceLastService: json['device_last_service'] as String? ?? '',
  deviceFilterHealth: (json['device_filter_health'] as num?)?.toDouble() ?? 1.0,
  totalVisits: (json['total_visits'] as num?)?.toInt() ?? 0,
  activeAmc: json['active_amc'] as bool? ?? false,
  customerValue: json['customer_value'] as String? ?? '0',
  openTickets: (json['open_tickets'] as num?)?.toInt() ?? 0,
  serviceHistory:
      (json['service_history'] as List<dynamic>?)
          ?.map((e) => ServiceActivity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isRentCustomer: _readIsRentCustomer(json, 'isRentCustomer') as bool? ?? false,
  rentAmount: (_readRentAmount(json, 'rentAmount') as num?)?.toDouble() ?? 0.0,
  rentDueDay: (_readRentDueDay(json, 'rentDueDay') as num?)?.toInt() ?? 1,
  isDeleted: json['is_deleted'] as bool? ?? false,
  deletedAt: json['deleted_at'] as String?,
  deletedBy: json['deleted_by'] as String?,
);

Map<String, dynamic> _$$CustomerImplToJson(
  _$CustomerImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'customer_id': instance.customerId,
  'number': instance.number,
  'email': instance.email,
  'address': instance.address,
  'locality': instance.locality,
  'ro_type': instance.roType,
  'note': instance.note,
  'role': instance.role,
  'status': instance.status,
  'customer_type': instance.customerType,
  'avatar_url': instance.avatarUrl,
  'device_name': instance.deviceName,
  'device_installed_on': instance.deviceInstalledOn,
  'device_last_service': instance.deviceLastService,
  'device_filter_health': instance.deviceFilterHealth,
  'total_visits': instance.totalVisits,
  'active_amc': instance.activeAmc,
  'customer_value': instance.customerValue,
  'open_tickets': instance.openTickets,
  'service_history': instance.serviceHistory.map((e) => e.toJson()).toList(),
  'isRentCustomer': instance.isRentCustomer,
  'rentAmount': instance.rentAmount,
  'rentDueDay': instance.rentDueDay,
  'is_deleted': instance.isDeleted,
  'deleted_at': instance.deletedAt,
  'deleted_by': instance.deletedBy,
};
