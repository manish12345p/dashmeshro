import '../repositories/calendar_repository_interface.dart';

class DismissScheduleUseCase {
  final ICalendarRepository _repository;

  DismissScheduleUseCase(this._repository);

  Future<void> execute(String customerId, String serviceId, bool isDismissed) {
    return _repository.dismissSchedule(customerId, serviceId, isDismissed);
  }
}
