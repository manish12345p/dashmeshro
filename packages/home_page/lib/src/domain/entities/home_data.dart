import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_data.freezed.dart';
part 'home_data.g.dart';

@freezed
class ExpiryItem with _$ExpiryItem {
  const ExpiryItem._();

  const factory ExpiryItem({
    @Default('') String customerName,
    @Default('') String customerId,
    @Default('') String type, // 'Service' or 'Guarantee'
    @Default('') String expiryDate,
    @Default('') String phone,
  }) = _ExpiryItem;

  factory ExpiryItem.fromJson(Map<String, dynamic> json) => _$ExpiryItemFromJson(json);
}

@freezed
class PendingPaymentItem with _$PendingPaymentItem {
  const PendingPaymentItem._();

  const factory PendingPaymentItem({
    @Default('') String customerName,
    @Default('') String customerId,
    @Default(0.0) double amountPending,
    @Default('') String phone,
  }) = _PendingPaymentItem;

  factory PendingPaymentItem.fromJson(Map<String, dynamic> json) => _$PendingPaymentItemFromJson(json);
}

@freezed
class ScheduleItem with _$ScheduleItem {
  const ScheduleItem._();

  const factory ScheduleItem({
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String time,
    @Default(false) bool isUrgent,
    @Default('') String phone,
    @Default('') String customerId,
  }) = _ScheduleItem;

  factory ScheduleItem.fromJson(Map<String, dynamic> json) => _$ScheduleItemFromJson(json);
}

@freezed
class ComplaintItem with _$ComplaintItem {
  const ComplaintItem._();

  const factory ComplaintItem({
    @Default('') String customerName,
    @Default('') String customerId,
    @Default('') String issueType,
    @Default('') String status,
  }) = _ComplaintItem;

  factory ComplaintItem.fromJson(Map<String, dynamic> json) => _$ComplaintItemFromJson(json);
}

@freezed
class AmcProgress with _$AmcProgress {
  const AmcProgress._();

  const factory AmcProgress({
    @Default('') String companyName,
    @Default(0.0) double progress,
    @Default('') String statusText,
    @Default(false) bool isUrgent,
  }) = _AmcProgress;

  factory AmcProgress.fromJson(Map<String, dynamic> json) => _$AmcProgressFromJson(json);
}

@freezed
class NotificationItem with _$NotificationItem {
  const NotificationItem._();

  const factory NotificationItem({
    @Default('') String customerName,
    @Default('') String customerId,
    @Default('') String address,
    @Default('') String serviceType,
    @Default('') String serviceId,
    @Default('') String notificationDate,
    @Default(false) bool isDismissed,
    @Default('') String phone,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) => _$NotificationItemFromJson(json);
}

@freezed
class HomeData with _$HomeData {
  const HomeData._();

  const factory HomeData({
    @Default(0) int newSells,
    @Default(0) int activeRentals,
    @Default(0) int activeAmcs,
    @Default(0) int totalServices,
    @Default(0.0) double totalCollectedThisMonth,
    @Default(0) int amcServices,
    @Default(0) int newRoServices,
    @Default(0) int repairServices,
    @Default(0) int resolutionRatePercent,
    @Default(0) int pendingComplaintsCount,
    @Default([]) List<ScheduleItem> todaySchedules,
    @Default([]) List<ComplaintItem> pendingComplaints,
    @Default([]) List<AmcProgress> amcProgresses,
    @Default([]) List<NotificationItem> todayNotifications,
    @Default([]) List<ExpiryItem> expiringItems,
    @Default([]) List<PendingPaymentItem> pendingPayments,
    @Default(0) int todaySellsSummary,
    @Default(0) int weekSellsSummary,
    @Default('') String projectedGrowth,
  }) = _HomeData;

  factory HomeData.fromJson(Map<String, dynamic> json) => _$HomeDataFromJson(json);
}
