import 'dart:async';
import '../../domain/entities/history_item.dart';
import 'history_remote_data_source.dart';

class FakeHistoryRemoteDataSource implements IHistoryRemoteDataSource {
  @override
  Stream<List<HistoryItem>> getAllServices() async* {
    yield [
      HistoryItem(
        id: 'fake_hist_1',
        customerId: 'fake_cust_1',
        customerName: 'John Doe',
        customerAddress: '123 Fake Street',
        customerPhone: '9876543210',
        serviceType: 'Installation',
        serviceDate: DateTime.now().subtract(const Duration(days: 2)),
        note: 'Installed new Aquaguard',
        fault: '',
        status: 'completed',
        serviceDuration: '1 year',
        guaranteeDuration: '1 year',
        totalAmount: 15000.0,
        amountPaid: 15000.0,
        amountPending: 0.0,
        isComplaint: false,
      ),
      HistoryItem(
        id: 'fake_hist_2',
        customerId: 'fake_cust_2',
        customerName: 'Jane Smith',
        customerAddress: '456 Mock Avenue',
        customerPhone: '9123456780',
        serviceType: 'Repair',
        serviceDate: DateTime.now().subtract(const Duration(days: 5)),
        note: 'Fixed leakage',
        fault: 'Filter leak',
        status: 'completed',
        serviceDuration: '',
        guaranteeDuration: '',
        totalAmount: 500.0,
        amountPaid: 500.0,
        amountPending: 0.0,
        isComplaint: true,
      ),
    ];
  }
}
