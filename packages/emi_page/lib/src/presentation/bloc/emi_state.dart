import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/emi_dashboard_data.dart';

// removed part

enum EmiStatus { initial, loading, success, failure }

class EmiState {
  final EmiStatus status;
  final EmiDashboardData? data;
  final String? errorMessage;
  final String selectedFilter;
  final String searchQuery;
  final List<dynamic> paymentHistory;

  const EmiState({
    this.status = EmiStatus.initial,
    this.data,
    this.errorMessage,
    this.selectedFilter = 'All',
    this.searchQuery = '',
    this.paymentHistory = const [],
  });

  factory EmiState.initial() => const EmiState();

  EmiState copyWith({
    EmiStatus? status,
    EmiDashboardData? data,
    String? errorMessage,
    String? selectedFilter,
    String? searchQuery,
    List<dynamic>? paymentHistory,
  }) {
    return EmiState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      paymentHistory: paymentHistory ?? this.paymentHistory,
    );
  }
}
