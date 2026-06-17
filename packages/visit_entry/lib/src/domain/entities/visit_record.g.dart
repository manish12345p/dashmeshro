// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitRecordImpl _$$VisitRecordImplFromJson(Map<String, dynamic> json) =>
    _$VisitRecordImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      serviceType: json['serviceType'] as String,
      serviceDate: DateTime.parse(json['serviceDate'] as String),
      remarks: json['remarks'] as String,
      isUrgent: json['isUrgent'] as bool? ?? false,
      isComplaint: json['isComplaint'] as bool? ?? false,
      fixes: json['fixes'] as String? ?? '',
      amountPaid: (json['amountPaid'] as num?)?.toDouble() ?? 0.0,
      amountPending: (json['amountPending'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      equipmentsUsed: json['equipmentsUsed'] as String? ?? '',
      serviceDuration: json['serviceDuration'] as String? ?? '',
      guaranteeDuration: json['guaranteeDuration'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      roType: json['roType'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      deletedAt: json['deletedAt'] as String?,
      deletedBy: json['deletedBy'] as String?,
    );

Map<String, dynamic> _$$VisitRecordImplToJson(_$VisitRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'serviceType': instance.serviceType,
      'serviceDate': instance.serviceDate.toIso8601String(),
      'remarks': instance.remarks,
      'isUrgent': instance.isUrgent,
      'isComplaint': instance.isComplaint,
      'fixes': instance.fixes,
      'amountPaid': instance.amountPaid,
      'amountPending': instance.amountPending,
      'totalAmount': instance.totalAmount,
      'equipmentsUsed': instance.equipmentsUsed,
      'serviceDuration': instance.serviceDuration,
      'guaranteeDuration': instance.guaranteeDuration,
      'status': instance.status,
      'roType': instance.roType,
      'isDeleted': instance.isDeleted,
      'deletedAt': instance.deletedAt,
      'deletedBy': instance.deletedBy,
    };
