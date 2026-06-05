import 'package:freezed_annotation/freezed_annotation.dart';

part 'emi_dashboard_data.freezed.dart';
part 'emi_dashboard_data.g.dart';

@freezed
class EmiDashboardData with _$EmiDashboardData {
  const factory EmiDashboardData({
    required double totalCollection,
    required double collectedThisMonth,
    required double lifetimeServiceRevenue,
    required double collectionGrowthPercentage,
    required double pendingThisMonth,
    required int pendingClientsCount,
    required double monthlyTargetCollectionPercentage,
    required List<RecentlyPaidInstallment> recentlyPaidInstallments,
    required List<ActiveInstallment> activeInstallments,
    required double onTimePaymentPercentage,
    required int earlyPayments,
    required int gracePeriod,
    required int defaulters,
  }) = _EmiDashboardData;

  factory EmiDashboardData.fromJson(Map<String, dynamic> json) => _$EmiDashboardDataFromJson(json);
}

@freezed
class RecentlyPaidInstallment with _$RecentlyPaidInstallment {
  const factory RecentlyPaidInstallment({
    required String id,
    required String customerId,
    required String customerName,
    required double amount,
    required String paidDateStr,
  }) = _RecentlyPaidInstallment;

  factory RecentlyPaidInstallment.fromJson(Map<String, dynamic> json) => _$RecentlyPaidInstallmentFromJson(json);
}

@freezed
class ActiveInstallment with _$ActiveInstallment {
  const factory ActiveInstallment({
    required String id,
    required String customerId,
    required String customerName,
    required String vehicleDetails,
    required double amount,
    required double totalAmount,
    @Default(0.0) double originalLoanAmount,
    @Default('') String serviceName,
    @Default(0.0) double lastPaymentAmount,
    @Default('') String lastPaymentDateStr,
    required String dueDate,
    required String status,
    required String avatarUrl,
  }) = _ActiveInstallment;

  factory ActiveInstallment.fromJson(Map<String, dynamic> json) => _$ActiveInstallmentFromJson(json);
}
