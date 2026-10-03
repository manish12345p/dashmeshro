import 'dart:async';
import '../../domain/entities/schedule_item.dart';
import 'calendar_remote_data_source.dart';

class FakeCalendarRemoteDataSource implements ICalendarRemoteDataSource {
  @override
  Stream<List<ScheduleItem>> getSchedulesForMonth(int year, int month) async* {
    final now = DateTime.now();
    yield [
      ScheduleItem(
        id: 'fake_sched_1',
        name: 'John Doe',
        machineId: '123 Fake Street',
        time: 'Pending: 10:00 AM',
        category: 'General',
        badgeLabel: 'Pending',
        status: 'pending',
        date: DateTime(year, month, 15),
        phone: '9876543210',
        customerId: 'fake_cust_1',
        isDismissed: false,
      ),
      ScheduleItem(
        id: 'fake_sched_2',
        name: 'Jane Smith',
        machineId: '456 Mock Avenue',
        time: 'Due 25/$month/$year',
        category: '3-Month Recurring Service',
        badgeLabel: '3-Month',
        status: 'pending',
        date: DateTime(year, month, 25),
        phone: '9123456780',
        customerId: 'fake_cust_2',
        isDismissed: false,
      ),
    ];
  }

  @override
  Future<void> dismissSchedule(String customerId, String serviceId, bool isDismissed) async {
    // Fake implementation, does nothing but simulate a delay
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
