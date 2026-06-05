import '../entities/schedule_item.dart';
import '../repositories/calendar_repository_interface.dart';

class GetCalendarSchedulesUseCase {
  final ICalendarRepository repository;

  GetCalendarSchedulesUseCase(this.repository);

  Stream<List<ScheduleItem>> execute(int year, int month) {
    return repository.getSchedulesForMonth(year, month);
  }
}
