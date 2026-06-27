import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_item.freezed.dart';
part 'history_item.g.dart';

@freezed
class HistoryItem with _$HistoryItem {
  @JsonSerializable(explicitToJson: true)
  const factory HistoryItem({
    required String id,
    required String customerId,
    @Default('') String customerName,
    @Default('') String customerAddress,
    @Default('') String customerPhone,
    @Default('') String serviceType,
    required DateTime serviceDate,
    @Default('') String note,
    @Default('') String fault,
    @Default('pending') String status,
    @Default('') String serviceDuration,
    @Default('') String guaranteeDuration,
    @Default(0.0) double totalAmount,
    @Default(0.0) double amountPaid,
    @Default(0.0) double amountPending,
    @Default(false) bool isComplaint,
  }) = _HistoryItem;

  factory HistoryItem.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemFromJson(json);
}
