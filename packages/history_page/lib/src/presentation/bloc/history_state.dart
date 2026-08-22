import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/history_item.dart';

part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(true) bool isLoading,
    @Default([]) List<HistoryItem> allServices,
    @Default('') String searchQuery,
    @Default('All') String selectedServiceType,
    @Default(false) bool amountFilterEnabled,
    String? errorMessage,
  }) = _HistoryState;

  factory HistoryState.initial() => const HistoryState();
}
