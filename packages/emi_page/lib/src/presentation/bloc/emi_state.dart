import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/emi_dashboard_data.dart';

part 'emi_state.freezed.dart';

enum EmiStatus { initial, loading, success, failure }

@freezed
class EmiState with _$EmiState {
  const factory EmiState({
    @Default(EmiStatus.initial) EmiStatus status,
    EmiDashboardData? data,
    String? errorMessage,
    @Default('All') String selectedFilter,
    @Default('') String searchQuery,
  }) = _EmiState;

  factory EmiState.initial() => const EmiState();
}
