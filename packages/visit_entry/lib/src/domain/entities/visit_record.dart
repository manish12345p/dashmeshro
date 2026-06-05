import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_record.freezed.dart';
part 'visit_record.g.dart';

@freezed
class VisitRecord with _$VisitRecord {
  @JsonSerializable(explicitToJson: true)
  const factory VisitRecord({
    required String id,
    required String customerId,
    required String serviceType,
    required DateTime serviceDate,
    required String remarks,
    @Default(false) bool isUrgent,
    @Default('') String fixes,
    @Default(0.0) double amountPaid,
    @Default(0.0) double amountPending,
    @Default(0.0) double totalAmount,
    @Default('') String equipmentsUsed,
    @Default('') String serviceDuration,
    @Default('') String guaranteeDuration,
    String? roType,
    @Default(false) bool isDeleted,
    String? deletedAt,
    String? deletedBy,
  }) = _VisitRecord;

  factory VisitRecord.fromJson(Map<String, dynamic> json) =>
      _$VisitRecordFromJson(json);
}
