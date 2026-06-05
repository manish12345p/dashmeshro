import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.loadMonth(int year, int month) = LoadMonth;
  const factory CalendarEvent.selectDate(DateTime date) = SelectDate;
  const factory CalendarEvent.selectCategory(String category) = SelectCategory;
  const factory CalendarEvent.searchQueryChanged(String query) = SearchQueryChanged;
}
