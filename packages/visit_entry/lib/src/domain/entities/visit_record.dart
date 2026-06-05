import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_record.freezed.dart';
part 'visit_record.g.dart';

@freezed
class VisitRecord with _$VisitRecord {
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

  const VisitRecord._();

  factory VisitRecord.fromJson(Map<String, dynamic> json) =>
      _$VisitRecordFromJson(json);

  factory VisitRecord.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return VisitRecord(
      id: documentId ?? map['id'] as String? ?? '',
      customerId: map['customerId'] as String? ?? '',
      serviceType: map['serviceType'] as String? ?? '',
      isUrgent: map['isUrgent'] as bool? ?? false,
      serviceDate: map['serviceDate'] != null
          ? DateTime.tryParse(map['serviceDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      remarks: map['remarks'] as String? ?? '',
      fixes: map['fixes'] as String? ?? '',
      amountPaid: (map['amountPaid'] ?? 0.0).toDouble(),
      amountPending: (map['amountPending'] ?? 0.0).toDouble(),
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
      equipmentsUsed: map['equipmentsUsed'] as String? ?? '',
      serviceDuration: map['serviceDuration'] as String? ?? '',
      guaranteeDuration: map['guaranteeDuration'] as String? ?? '',
      roType: map['roType'] as String?,
      isDeleted: map['isDeleted'] as bool? ?? false,
      deletedAt: map['deletedAt'] as String?,
      deletedBy: map['deletedBy'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'customerId': customerId,
      'serviceType': serviceType,
      'serviceDate': serviceDate.toIso8601String(),
    };
    if (isUrgent) map['isUrgent'] = isUrgent;
    if (remarks.isNotEmpty) map['remarks'] = remarks;
    if (fixes.isNotEmpty) map['fixes'] = fixes;
    if (amountPaid > 0) map['amountPaid'] = amountPaid;
    if (amountPending > 0) map['amountPending'] = amountPending;
    if (totalAmount > 0) map['totalAmount'] = totalAmount;
    if (equipmentsUsed.isNotEmpty) map['equipmentsUsed'] = equipmentsUsed;
    if (serviceDuration.isNotEmpty) map['serviceDuration'] = serviceDuration;
    if (guaranteeDuration.isNotEmpty)
      map['guaranteeDuration'] = guaranteeDuration;
    if (roType != null && roType!.isNotEmpty) map['roType'] = roType;
    map['isDeleted'] = isDeleted;
    if (deletedAt != null) map['deletedAt'] = deletedAt;
    if (deletedBy != null) map['deletedBy'] = deletedBy;
    return map;
  }
}
