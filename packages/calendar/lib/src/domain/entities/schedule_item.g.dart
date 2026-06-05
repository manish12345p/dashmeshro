// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleItemImpl _$$ScheduleItemImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      machineId: json['machineId'] as String,
      time: json['time'] as String,
      category: json['category'] as String,
      badgeLabel: json['badgeLabel'] as String,
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
      isDismissed: json['isDismissed'] as bool? ?? false,
      phone: json['phone'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
    );

Map<String, dynamic> _$$ScheduleItemImplToJson(_$ScheduleItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'machineId': instance.machineId,
      'time': instance.time,
      'category': instance.category,
      'badgeLabel': instance.badgeLabel,
      'status': instance.status,
      'date': instance.date.toIso8601String(),
      'isDismissed': instance.isDismissed,
      'phone': instance.phone,
      'customerId': instance.customerId,
    };
