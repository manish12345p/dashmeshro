import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_data.freezed.dart';

@freezed
class ScheduleItem with _$ScheduleItem {
  const ScheduleItem._();

  const factory ScheduleItem({
    required String title,
    required String subtitle,
    required String time,
    @Default(false) bool isUrgent,
  }) = _ScheduleItem;

  factory ScheduleItem.fromMap(Map<String, dynamic> map) {
    return ScheduleItem(
      title: map['title'] as String? ?? '',
      subtitle: map['subtitle'] as String? ?? '',
      time: map['time'] as String? ?? '',
      isUrgent: map['isUrgent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'time': time,
      'isUrgent': isUrgent,
    };
  }
}

@freezed
class ComplaintItem with _$ComplaintItem {
  const ComplaintItem._();

  const factory ComplaintItem({
    required String customerName,
    required String customerId,
    required String issueType,
    required String status,
  }) = _ComplaintItem;

  factory ComplaintItem.fromMap(Map<String, dynamic> map) {
    return ComplaintItem(
      customerName: map['customerName'] as String? ?? '',
      customerId: map['customerId'] as String? ?? '',
      issueType: map['issueType'] as String? ?? '',
      status: map['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerId': customerId,
      'issueType': issueType,
      'status': status,
    };
  }
}

@freezed
class AmcProgress with _$AmcProgress {
  const AmcProgress._();

  const factory AmcProgress({
    required String companyName,
    required double progress,
    required String statusText,
    @Default(false) bool isUrgent,
  }) = _AmcProgress;

  factory AmcProgress.fromMap(Map<String, dynamic> map) {
    return AmcProgress(
      companyName: map['companyName'] as String? ?? '',
      progress: (map['progress'] as num?)?.toDouble() ?? 0.0,
      statusText: map['statusText'] as String? ?? '',
      isUrgent: map['isUrgent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'progress': progress,
      'statusText': statusText,
      'isUrgent': isUrgent,
    };
  }
}

@freezed
class HomeData with _$HomeData {
  const HomeData._();

  const factory HomeData({
    required int newSells,
    required int activeRentals,
    required int activeAmcs,
    required int resolutionRatePercent,
    required int pendingComplaintsCount,
    required List<ScheduleItem> todaySchedules,
    required List<ComplaintItem> pendingComplaints,
    required List<AmcProgress> amcProgresses,
    required int todaySellsSummary,
    required int weekSellsSummary,
    required String projectedGrowth,
  }) = _HomeData;

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      newSells: map['newSells'] as int? ?? 0,
      activeRentals: map['activeRentals'] as int? ?? 0,
      activeAmcs: map['activeAmcs'] as int? ?? 0,
      resolutionRatePercent: map['resolutionRatePercent'] as int? ?? 0,
      pendingComplaintsCount: map['pendingComplaintsCount'] as int? ?? 0,
      todaySchedules: (map['todaySchedules'] as List<dynamic>?)
              ?.map((e) => ScheduleItem.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      pendingComplaints: (map['pendingComplaints'] as List<dynamic>?)
              ?.map((e) => ComplaintItem.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      amcProgresses: (map['amcProgresses'] as List<dynamic>?)
              ?.map((e) => AmcProgress.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      todaySellsSummary: map['todaySellsSummary'] as int? ?? 0,
      weekSellsSummary: map['weekSellsSummary'] as int? ?? 0,
      projectedGrowth: map['projectedGrowth'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'newSells': newSells,
      'activeRentals': activeRentals,
      'activeAmcs': activeAmcs,
      'resolutionRatePercent': resolutionRatePercent,
      'pendingComplaintsCount': pendingComplaintsCount,
      'todaySchedules': todaySchedules.map((e) => e.toMap()).toList(),
      'pendingComplaints': pendingComplaints.map((e) => e.toMap()).toList(),
      'amcProgresses': amcProgresses.map((e) => e.toMap()).toList(),
      'todaySellsSummary': todaySellsSummary,
      'weekSellsSummary': weekSellsSummary,
      'projectedGrowth': projectedGrowth,
    };
  }
}
