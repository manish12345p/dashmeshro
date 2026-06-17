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
  serviceDuration: json['serviceDuration'] as String? ?? '',
  guaranteeDuration: json['guaranteeDuration'] as String? ?? '',
  remarks: json['remarks'] as String? ?? '',
  status: json['status'] as String? ?? 'pending',
  isComplaint: json['isComplaint'] as bool? ?? false,
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
  'serviceDuration': instance.serviceDuration,
  'guaranteeDuration': instance.guaranteeDuration,
  'remarks': instance.remarks,
  'status': instance.status,
  'isComplaint': instance.isComplaint,
  'serviceDate': instance.serviceDate.toIso8601String(),
};

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String,
      customerId: json['customer_id'] as String,
      number: json['number'] as String,
      address: json['address'] as String? ?? '',
      locality: json['locality'] as String? ?? '',
      roType: json['ro_type'] as String? ?? '',
      note: json['note'] as String? ?? '',
      serviceHistory:
          (json['service_history'] as List<dynamic>?)
              ?.map((e) => ServiceActivity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalAmcVisits: (json['total_amc_visits'] as num?)?.toInt() ?? 0,
      remainingAmcVisits: (json['remaining_amc_visits'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CustomerImplToJson(
  _$CustomerImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'customer_id': instance.customerId,
  'number': instance.number,
  'address': instance.address,
  'locality': instance.locality,
  'ro_type': instance.roType,
  'note': instance.note,
  'service_history': instance.serviceHistory.map((e) => e.toJson()).toList(),
  'total_amc_visits': instance.totalAmcVisits,
  'remaining_amc_visits': instance.remainingAmcVisits,
};
