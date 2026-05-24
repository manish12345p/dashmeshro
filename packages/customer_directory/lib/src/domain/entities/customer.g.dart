// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceActivityImpl _$$ServiceActivityImplFromJson(
  Map<String, dynamic> json,
) => _$ServiceActivityImpl(
  activityType: json['activityType'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  technicianName: json['technicianName'] as String,
  dateText: json['dateText'] as String,
  statusBadge: json['statusBadge'] as String,
);

Map<String, dynamic> _$$ServiceActivityImplToJson(
  _$ServiceActivityImpl instance,
) => <String, dynamic>{
  'activityType': instance.activityType,
  'title': instance.title,
  'description': instance.description,
  'technicianName': instance.technicianName,
  'dateText': instance.dateText,
  'statusBadge': instance.statusBadge,
};

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      customerId: json['customerId'] as String,
      number: json['number'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      locality: json['locality'] as String,
      roType: json['roType'] as String,
      note: json['note'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      customerType: json['customerType'] as String,
      avatarUrl: json['avatarUrl'] as String,
      deviceName: json['deviceName'] as String,
      deviceInstalledOn: json['deviceInstalledOn'] as String,
      deviceLastService: json['deviceLastService'] as String,
      deviceFilterHealth: (json['deviceFilterHealth'] as num).toDouble(),
      totalVisits: (json['totalVisits'] as num).toInt(),
      activeAmc: json['activeAmc'] as bool,
      customerValue: json['customerValue'] as String,
      openTickets: (json['openTickets'] as num).toInt(),
      serviceHistory: (json['serviceHistory'] as List<dynamic>)
          .map((e) => ServiceActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
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
    };
