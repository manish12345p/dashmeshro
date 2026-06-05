import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_calendar_schedules_usecase.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';
import '../../domain/use_cases/dismiss_schedule_usecase.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetCalendarSchedulesUseCase _getCalendarSchedulesUseCase;
  final DismissScheduleUseCase _dismissScheduleUseCase;
  StreamSubscription? _schedulesSubscription;

  CalendarBloc({
    required GetCalendarSchedulesUseCase getCalendarSchedulesUseCase,
    required DismissScheduleUseCase dismissScheduleUseCase,
  }) : _getCalendarSchedulesUseCase = getCalendarSchedulesUseCase,
       _dismissScheduleUseCase = dismissScheduleUseCase,
       super(CalendarState.initial()) {
    on<LoadMonth>(_onLoadMonth);
    on<SelectDate>(_onSelectDate);
    on<SelectCategory>(_onSelectCategory);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<DismissSchedule>(_onDismissSchedule);
  }

  Future<void> _onLoadMonth(
    LoadMonth event,
    Emitter<CalendarState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        currentYear: event.year,
        currentMonth: event.month,
      ),
    );

    await _schedulesSubscription?.cancel();

    final completer = Completer<void>();
    _schedulesSubscription = _getCalendarSchedulesUseCase
        .execute(event.year, event.month)
        .listen(
          (schedules) {
            emit(
              state.copyWith(
                isLoading: false,
                currentMonthSchedules: schedules,
                errorMessage: null,
              ),
            );
            if (!completer.isCompleted) completer.complete();
          },
          onError: (error) {
            emit(
              state.copyWith(isLoading: false, errorMessage: error.toString()),
            );
            if (!completer.isCompleted) completer.completeError(error);
          },
        );

    try {
      await completer.future;
    } catch (_) {}
  }

  void _onSelectDate(SelectDate event, Emitter<CalendarState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onSelectCategory(SelectCategory event, Emitter<CalendarState> emit) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<CalendarState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _onDismissSchedule(
    DismissSchedule event,
    Emitter<CalendarState> emit,
  ) async {
    try {
      await _dismissScheduleUseCase.execute(
        event.item.customerId,
        event.item.id,
        event.isDismissed,
      );
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _schedulesSubscription?.cancel();
    return super.close();
  }
}
