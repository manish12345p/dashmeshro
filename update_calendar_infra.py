# -*- coding: utf-8 -*-
import io, re

# Update injection_container.dart
with io.open(r'lib/injection_container.dart', 'r', encoding='utf-8') as f:
    inj_content = f.read()

calendar_inj = """  // Feature: Calendar
  sl.registerLazySingleton<ICalendarRepository>(
    () => CalendarRepository(),
  );
  sl.registerLazySingleton(
    () => GetCalendarSchedulesUseCase(sl()),
  );
  sl.registerFactory(
    () => CalendarBloc(getCalendarSchedulesUseCase: sl()),
  );

  // Other features..."""

inj_content = inj_content.replace("// Other features...", calendar_inj)
with io.open(r'lib/injection_container.dart', 'w', encoding='utf-8') as f:
    f.write(inj_content)

# Update calendar.dart
with io.open(r'packages/calendar/lib/calendar.dart', 'r', encoding='utf-8') as f:
    cal_content = f.read()

exports = """
export 'src/domain/repositories/calendar_repository_interface.dart';
export 'src/data/repositories/calendar_repository.dart';
export 'src/domain/use_cases/get_calendar_schedules_usecase.dart';
export 'src/presentation/bloc/calendar_bloc.dart';
export 'src/presentation/bloc/calendar_event.dart';
export 'src/presentation/bloc/calendar_state.dart';
"""
if "calendar_bloc.dart" not in cal_content:
    cal_content += exports

with io.open(r'packages/calendar/lib/calendar.dart', 'w', encoding='utf-8') as f:
    f.write(cal_content)
