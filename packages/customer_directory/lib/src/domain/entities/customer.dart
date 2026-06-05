import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class ServiceActivity with _$ServiceActivity {
  @JsonSerializable(explicitToJson: true)
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

  factory ServiceActivity.fromJson(Map<String, dynamic> json) =>
      _$ServiceActivityFromJson(json);
}

@freezed
class Customer with _$Customer {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory Customer({
    @Default('') String id,
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
    @Default('Active AMC') String customerType,
    @Default('') String avatarUrl,
    @Default('') String deviceName,
    @Default('') String deviceInstalledOn,
    @Default('') String deviceLastService,
    @Default(1.0) double deviceFilterHealth,
    @Default(0) int totalVisits,
    @Default(false) bool activeAmc,
    @Default('0') String customerValue,
    @Default(0) int openTickets,
    @Default([]) List<ServiceActivity> serviceHistory,
    @Default(false) @JsonKey(name: 'isRentCustomer', readValue: _readIsRentCustomer) bool isRentCustomer,
    @Default(0.0) @JsonKey(name: 'rentAmount', readValue: _readRentAmount) double rentAmount,
    @Default(1) @JsonKey(name: 'rentDueDay', readValue: _readRentDueDay) int rentDueDay,
    @Default(false) bool isDeleted,
    String? deletedAt,
    String? deletedBy,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

Object? _readIsRentCustomer(Map map, String key) => map['isRentCustomer'] ?? map['is_rent_customer'] ?? false;
Object? _readRentAmount(Map map, String key) => map['rentAmount'] ?? map['rent_amount'] ?? 0.0;
Object? _readRentDueDay(Map map, String key) => map['rentDueDay'] ?? map['rent_due_day'] ?? 1;
