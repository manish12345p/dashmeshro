import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class ServiceActivity with _$ServiceActivity {
  const factory ServiceActivity({
    required String activityType, // 'complaint', 'maintenance', 'receipt', 'installation'
    required String title,
    required String description,
    required String technicianName,
    required String dateText,
    required String statusBadge, // 'urgent', 'healthy', 'financial', 'setup'
  }) = _ServiceActivity;

  const ServiceActivity._();

  factory ServiceActivity.fromJson(Map<String, dynamic> json) =>
      _$ServiceActivityFromJson(json);

  factory ServiceActivity.fromMap(Map<String, dynamic> map) {
    return ServiceActivity(
      activityType: map['activityType'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      technicianName: map['technicianName'] as String? ?? '',
      dateText: map['dateText'] as String? ?? '',
      statusBadge: map['statusBadge'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activityType': activityType,
      'title': title,
      'description': description,
      'technicianName': technicianName,
      'dateText': dateText,
      'statusBadge': statusBadge,
    };
  }
}

@freezed
class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String name,
    required String customerId,
    required String number,
    required String email,
    required String address,
    required String locality,
    required String roType,
    required String note,
    required String role,
    required String status, // 'active', 'inactive'
    required String customerType, // 'Active AMC', 'Rental Customer', 'Recent Purchase', 'Open Complaint'
    required String avatarUrl,
    required String deviceName,
    required String deviceInstalledOn,
    required String deviceLastService,
    required double deviceFilterHealth, // between 0.0 and 1.0
    required int totalVisits,
    required bool activeAmc,
    required String customerValue, // e.g. '18.5k'
    required int openTickets,
    required List<ServiceActivity> serviceHistory,
  }) = _Customer;

  const Customer._();

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  factory Customer.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return Customer(
      id: documentId ?? map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      customerId: map['customer_id'] as String? ?? map['customerId'] as String? ?? '',
      number: map['number'] as String? ?? '',
      email: map['email'] as String? ?? '',
      address: map['address'] as String? ?? '',
      locality: map['locality'] as String? ?? '',
      roType: map['ro_type'] as String? ?? map['roType'] as String? ?? '',
      note: map['note'] as String? ?? '',
      role: map['role'] as String? ?? '',
      status: map['status'] as String? ?? 'active',
      customerType: map['customer_type'] as String? ?? map['customerType'] as String? ?? 'Active AMC',
      avatarUrl: map['avatar_url'] as String? ?? map['avatarUrl'] as String? ?? '',
      deviceName: map['device_name'] as String? ?? map['deviceName'] as String? ?? '',
      deviceInstalledOn: map['device_installed_on'] as String? ?? map['deviceInstalledOn'] as String? ?? '',
      deviceLastService: map['device_last_service'] as String? ?? map['deviceLastService'] as String? ?? '',
      deviceFilterHealth: (map['device_filter_health'] ?? map['deviceFilterHealth'] ?? 1.0) as double,
      totalVisits: (map['total_visits'] ?? map['totalVisits'] ?? 0) as int,
      activeAmc: (map['active_amc'] ?? map['activeAmc'] ?? false) as bool,
      customerValue: map['customer_value'] as String? ?? map['customerValue'] as String? ?? '0',
      openTickets: (map['open_tickets'] ?? map['openTickets'] ?? 0) as int,
      serviceHistory: (map['service_history'] as List? ?? map['serviceHistory'] as List? ?? [])
          .map((item) => ServiceActivity.fromMap(Map<String, dynamic>.from(item as Map)))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'customer_id': customerId,
      'number': number,
      'email': email,
      'address': address,
      'locality': locality,
      'ro_type': roType,
      'note': note,
      'role': role,
      'status': status,
      'customer_type': customerType,
      'avatar_url': avatarUrl,
      'device_name': deviceName,
      'device_installed_on': deviceInstalledOn,
      'device_last_service': deviceLastService,
      'device_filter_health': deviceFilterHealth,
      'total_visits': totalVisits,
      'active_amc': activeAmc,
      'customer_value': customerValue,
      'open_tickets': openTickets,
      'service_history': serviceHistory.map((item) => item.toMap()).toList(),
    };
  }
}
