import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_item.freezed.dart';

@freezed
class ScheduleItem with _$ScheduleItem {
  const factory ScheduleItem({
    required String id,
    required String name,
    required String machineId,
    required String time,
    required String category,
    required String badgeLabel,
    required String status,
    required DateTime date,
    @Default(false) bool isDismissed,
    @Default('') String phone,
    @Default('') String customerId,
  }) = _ScheduleItem;
}

extension ScheduleItemColor on ScheduleItem {
  Color get statusColor {
    if (status.toLowerCase() == 'confirmed' ||
        status.toLowerCase() == 'resolved')
      return Colors.green;
    if (status.toLowerCase() == 'in progress' ||
        status.toLowerCase() == 'in_progress')
      return Colors.blue;
    return Colors.orange;
  }
}
