import 'dart:async';
import '../../domain/entities/schedule_item.dart';
import '../../domain/repositories/calendar_repository_interface.dart';
import '../datasources/calendar_remote_data_source.dart';

class CalendarRepository implements ICalendarRepository {
  final ICalendarRemoteDataSource remoteDataSource;

  CalendarRepository({required this.remoteDataSource});

  @override
  Stream<List<ScheduleItem>> getSchedulesForMonth(int year, int month) {
    return remoteDataSource.getSchedulesForMonth(year, month);
  }

  @override
  Future<void> dismissSchedule(String customerId, String serviceId, bool isDismissed) {
    return remoteDataSource.dismissSchedule(customerId, serviceId, isDismissed);
  }
}
