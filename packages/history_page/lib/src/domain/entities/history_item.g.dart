// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryItemImpl _$$HistoryItemImplFromJson(Map<String, dynamic> json) =>
    _$HistoryItemImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String? ?? '',
      customerAddress: json['customerAddress'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
      serviceType: json['serviceType'] as String? ?? '',
      serviceDate: DateTime.parse(json['serviceDate'] as String),
      note: json['note'] as String? ?? '',
      fault: json['fault'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      serviceDuration: json['serviceDuration'] as String? ?? '',
      guaranteeDuration: json['guaranteeDuration'] as String? ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      amountPaid: (json['amountPaid'] as num?)?.toDouble() ?? 0.0,
      amountPending: (json['amountPending'] as num?)?.toDouble() ?? 0.0,
      isComplaint: json['isComplaint'] as bool? ?? false,
    );

Map<String, dynamic> _$$HistoryItemImplToJson(_$HistoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerAddress': instance.customerAddress,
      'customerPhone': instance.customerPhone,
      'serviceType': instance.serviceType,
      'serviceDate': instance.serviceDate.toIso8601String(),
      'note': instance.note,
      'fault': instance.fault,
      'status': instance.status,
      'serviceDuration': instance.serviceDuration,
      'guaranteeDuration': instance.guaranteeDuration,
      'totalAmount': instance.totalAmount,
      'amountPaid': instance.amountPaid,
      'amountPending': instance.amountPending,
      'isComplaint': instance.isComplaint,
    };
