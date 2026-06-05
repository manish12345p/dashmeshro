import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/schedule_item.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState({
    required int currentYear,
    required int currentMonth,
    required DateTime selectedDate,
    required String selectedCategory,
    required String searchQuery,
    @Default(true) bool isLoading,
    @Default([]) List<ScheduleItem> currentMonthSchedules,
    String? errorMessage,
  }) = _CalendarState;

  factory CalendarState.initial() {
    final now = DateTime.now();
    return CalendarState(
      currentYear: now.year,
      currentMonth: now.month,
      selectedDate: DateTime(now.year, now.month, now.day),
      selectedCategory: 'All',
      searchQuery: '',
    );
  }
}
