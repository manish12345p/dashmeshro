import 'package:flutter/material.dart';

class MockScheduleItem {
  final String id;
  final String name;
  final String machineId;
  final String time;
  final String category;
  final String badgeLabel;
  final String status;
  final Color statusColor;

  const MockScheduleItem({
    required this.id,
    required this.name,
    required this.machineId,
    required this.time,
    required this.category,
    required this.badgeLabel,
    required this.status,
    required this.statusColor,
  });
}
