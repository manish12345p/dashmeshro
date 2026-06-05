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
    @Default('') String address,
    @Default('') String locality,
    @Default('') String roType,
    @Default('') String note,
    @Default([]) List<ServiceActivity> serviceHistory,
    @Default(0) int totalAmcVisits,
    @Default(0) int remainingAmcVisits,
    @Default(false) bool isDeleted,
    String? deletedAt,
    String? deletedBy,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
