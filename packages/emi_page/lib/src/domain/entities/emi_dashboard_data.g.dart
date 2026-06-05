// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emi_dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmiDashboardDataImpl _$$EmiDashboardDataImplFromJson(
  Map<String, dynamic> json,
) => _$EmiDashboardDataImpl(
  totalCollection: (json['totalCollection'] as num).toDouble(),
  collectedThisMonth: (json['collectedThisMonth'] as num).toDouble(),
  lifetimeServiceRevenue: (json['lifetimeServiceRevenue'] as num).toDouble(),
  collectionGrowthPercentage: (json['collectionGrowthPercentage'] as num)
      .toDouble(),
  pendingThisMonth: (json['pendingThisMonth'] as num).toDouble(),
  pendingClientsCount: (json['pendingClientsCount'] as num).toInt(),
  monthlyTargetCollectionPercentage:
      (json['monthlyTargetCollectionPercentage'] as num).toDouble(),
  recentlyPaidInstallments: (json['recentlyPaidInstallments'] as List<dynamic>)
      .map((e) => RecentlyPaidInstallment.fromJson(e as Map<String, dynamic>))
      .toList(),
  activeInstallments: (json['activeInstallments'] as List<dynamic>)
      .map((e) => ActiveInstallment.fromJson(e as Map<String, dynamic>))
      .toList(),
  onTimePaymentPercentage: (json['onTimePaymentPercentage'] as num).toDouble(),
  earlyPayments: (json['earlyPayments'] as num).toInt(),
  gracePeriod: (json['gracePeriod'] as num).toInt(),
  defaulters: (json['defaulters'] as num).toInt(),
);

Map<String, dynamic> _$$EmiDashboardDataImplToJson(
  _$EmiDashboardDataImpl instance,
) => <String, dynamic>{
  'totalCollection': instance.totalCollection,
  'collectedThisMonth': instance.collectedThisMonth,
  'lifetimeServiceRevenue': instance.lifetimeServiceRevenue,
  'collectionGrowthPercentage': instance.collectionGrowthPercentage,
  'pendingThisMonth': instance.pendingThisMonth,
  'pendingClientsCount': instance.pendingClientsCount,
  'monthlyTargetCollectionPercentage':
      instance.monthlyTargetCollectionPercentage,
  'recentlyPaidInstallments': instance.recentlyPaidInstallments,
  'activeInstallments': instance.activeInstallments,
  'onTimePaymentPercentage': instance.onTimePaymentPercentage,
  'earlyPayments': instance.earlyPayments,
  'gracePeriod': instance.gracePeriod,
  'defaulters': instance.defaulters,
};

_$RecentlyPaidInstallmentImpl _$$RecentlyPaidInstallmentImplFromJson(
  Map<String, dynamic> json,
) => _$RecentlyPaidInstallmentImpl(
  id: json['id'] as String,
  customerId: json['customerId'] as String,
  customerName: json['customerName'] as String,
  amount: (json['amount'] as num).toDouble(),
  paidDateStr: json['paidDateStr'] as String,
);

Map<String, dynamic> _$$RecentlyPaidInstallmentImplToJson(
  _$RecentlyPaidInstallmentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'customerName': instance.customerName,
  'amount': instance.amount,
  'paidDateStr': instance.paidDateStr,
};

_$ActiveInstallmentImpl _$$ActiveInstallmentImplFromJson(
  Map<String, dynamic> json,
) => _$ActiveInstallmentImpl(
  id: json['id'] as String,
  customerId: json['customerId'] as String,
  customerName: json['customerName'] as String,
  vehicleDetails: json['vehicleDetails'] as String,
  amount: (json['amount'] as num).toDouble(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  originalLoanAmount: (json['originalLoanAmount'] as num?)?.toDouble() ?? 0.0,
  serviceName: json['serviceName'] as String? ?? '',
  lastPaymentAmount: (json['lastPaymentAmount'] as num?)?.toDouble() ?? 0.0,
  lastPaymentDateStr: json['lastPaymentDateStr'] as String? ?? '',
  dueDate: json['dueDate'] as String,
  status: json['status'] as String,
  avatarUrl: json['avatarUrl'] as String,
);

Map<String, dynamic> _$$ActiveInstallmentImplToJson(
  _$ActiveInstallmentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'customerName': instance.customerName,
  'vehicleDetails': instance.vehicleDetails,
  'amount': instance.amount,
  'totalAmount': instance.totalAmount,
  'originalLoanAmount': instance.originalLoanAmount,
  'serviceName': instance.serviceName,
  'lastPaymentAmount': instance.lastPaymentAmount,
  'lastPaymentDateStr': instance.lastPaymentDateStr,
  'dueDate': instance.dueDate,
  'status': instance.status,
  'avatarUrl': instance.avatarUrl,
};
