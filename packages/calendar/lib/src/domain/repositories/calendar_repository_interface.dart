import '../entities/schedule_item.dart';

abstract class ICalendarRepository {
  Stream<List<ScheduleItem>> getSchedulesForMonth(int year, int month);
}
