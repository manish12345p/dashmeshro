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

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      customerId: json['customerId'] as String,
      number: json['number'] as String,
      email: json['email'] as String? ?? '',
      address: json['address'] as String? ?? '',
      locality: json['locality'] as String? ?? '',
      roType: json['roType'] as String? ?? '',
      note: json['note'] as String? ?? '',
      role: json['role'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      customerType: json['customerType'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      deviceName: json['deviceName'] as String? ?? '',
      deviceInstalledOn: json['deviceInstalledOn'] as String? ?? '',
      deviceLastService: json['deviceLastService'] as String? ?? '',
      deviceFilterHealth:
          (json['deviceFilterHealth'] as num?)?.toDouble() ?? 1.0,
      totalVisits: (json['totalVisits'] as num?)?.toInt() ?? 0,
      activeAmc: json['activeAmc'] as bool? ?? false,
      customerValue: json['customerValue'] as String? ?? '',
      openTickets: (json['openTickets'] as num?)?.toInt() ?? 0,
      serviceHistory:
          (json['serviceHistory'] as List<dynamic>?)
              ?.map((e) => ServiceActivity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isDeleted: json['isDeleted'] as bool? ?? false,
      deletedAt: json['deletedAt'] as String?,
      deletedBy: json['deletedBy'] as String?,
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'customerId': instance.customerId,
      'number': instance.number,
      'email': instance.email,
      'address': instance.address,
      'locality': instance.locality,
      'roType': instance.roType,
      'note': instance.note,
      'role': instance.role,
      'status': instance.status,
      'customerType': instance.customerType,
      'avatarUrl': instance.avatarUrl,
      'deviceName': instance.deviceName,
      'deviceInstalledOn': instance.deviceInstalledOn,
      'deviceLastService': instance.deviceLastService,
      'deviceFilterHealth': instance.deviceFilterHealth,
      'totalVisits': instance.totalVisits,
      'activeAmc': instance.activeAmc,
      'customerValue': instance.customerValue,
      'openTickets': instance.openTickets,
      'serviceHistory': instance.serviceHistory,
      'isDeleted': instance.isDeleted,
      'deletedAt': instance.deletedAt,
      'deletedBy': instance.deletedBy,
    };
