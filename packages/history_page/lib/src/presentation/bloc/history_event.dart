import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_event.freezed.dart';

@freezed
class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent.loadHistory() = LoadHistory;
  const factory HistoryEvent.searchQueryChanged(String query) =
      SearchQueryChanged;
  const factory HistoryEvent.filterByServiceType(String type) =
      FilterByServiceType;
}
