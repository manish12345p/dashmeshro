import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class ServiceActivity with _$ServiceActivity {
  const factory ServiceActivity({
    required String id,
    required String serviceType,
    required String fixes,
    required double totalAmount,
    required double amountPaid,
    required String equipmentsUsed,
    @Default('') String guaranteeDuration,
    @Default('') String remarks,
    required DateTime serviceDate,
  }) = _ServiceActivity;

  const ServiceActivity._();

  factory ServiceActivity.fromJson(Map<String, dynamic> json) =>
      _$ServiceActivityFromJson(json);

  factory ServiceActivity.fromMap(Map<String, dynamic> map) {
    return ServiceActivity(
      id: map['id'] as String? ?? '',
      serviceType: map['serviceType'] as String? ?? '',
      fixes: map['fixes'] as String? ?? '',
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
      amountPaid: (map['amountPaid'] ?? 0.0).toDouble(),
      equipmentsUsed: map['equipmentsUsed'] as String? ?? '',
      guaranteeDuration: map['guaranteeDuration'] as String? ?? '',
      remarks: map['remarks'] as String? ?? '',
      serviceDate: map['serviceDate'] != null
          ? DateTime.tryParse(map['serviceDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceType': serviceType,
      'fixes': fixes,
      'totalAmount': totalAmount,
      'amountPaid': amountPaid,
      'equipmentsUsed': equipmentsUsed,
      'guaranteeDuration': guaranteeDuration,
      'remarks': remarks,
      'serviceDate': serviceDate.toIso8601String(),
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
    @Default('') String email,
    @Default('') String address,
    @Default('') String locality,
    @Default('') String roType,
    @Default('') String note,
    @Default('') String role,
    @Default('active') String status,
    @Default('') String customerType,
    @Default('') String avatarUrl,
    @Default('') String deviceName,
    @Default('') String deviceInstalledOn,
    @Default('') String deviceLastService,
    @Default(1.0) double deviceFilterHealth,
    @Default(0) int totalVisits,
    @Default(false) bool activeAmc,
    @Default('') String customerValue,
    @Default(0) int openTickets,
    @Default([]) List<ServiceActivity> serviceHistory,
    
    // Soft delete support
    @Default(false) bool isDeleted,
    String? deletedAt,
    String? deletedBy,
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
      isDeleted: map['isDeleted'] as bool? ?? false,
      deletedAt: map['deletedAt'] as String?,
      deletedBy: map['deletedBy'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'customer_id': customerId,
      'number': number,
    };
    // Only include fields that have actual values
    if (id.isNotEmpty) map['id'] = id;
    if (email.isNotEmpty) map['email'] = email;
    if (address.isNotEmpty) map['address'] = address;
    if (locality.isNotEmpty) map['locality'] = locality;
    if (roType.isNotEmpty) map['ro_type'] = roType;
    if (note.isNotEmpty) map['note'] = note;
    if (role.isNotEmpty) map['role'] = role;
    if (status.isNotEmpty) map['status'] = status;
    if (customerType.isNotEmpty) map['customer_type'] = customerType;
    if (avatarUrl.isNotEmpty) map['avatar_url'] = avatarUrl;
    if (deviceName.isNotEmpty) map['device_name'] = deviceName;
    if (deviceInstalledOn.isNotEmpty) map['device_installed_on'] = deviceInstalledOn;
    if (deviceLastService.isNotEmpty) map['device_last_service'] = deviceLastService;
    if (deviceFilterHealth != 1.0) map['device_filter_health'] = deviceFilterHealth;
    if (totalVisits > 0) map['total_visits'] = totalVisits;
    if (activeAmc) map['active_amc'] = activeAmc;
    if (customerValue.isNotEmpty) map['customer_value'] = customerValue;
    if (openTickets > 0) map['open_tickets'] = openTickets;
    if (serviceHistory.isNotEmpty) map['service_history'] = serviceHistory.map((item) => item.toMap()).toList();
    map['isDeleted'] = isDeleted;
    if (deletedAt != null) map['deletedAt'] = deletedAt;
    if (deletedBy != null) map['deletedBy'] = deletedBy;
    return map;
  }
}
