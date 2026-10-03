import 'dart:async';
import '../../domain/entities/visit_record.dart';
import 'visit_entry_remote_data_source.dart';

class FakeVisitEntryRemoteDataSource implements IVisitEntryRemoteDataSource {
  @override
  Future<void> createVisitEntry(
    VisitRecord entry, {
    double? emiAmountPerMonth,
    int? totalAmcVisitsToPurchase,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real fake implementation, we might save this to a local list
  }

  @override
  Future<List<String>> getRoTypes() async {
    return ['Aquaguard', 'Kent', 'Pureit', 'Livpure', 'Other'];
  }

  @override
  Future<List<Map<String, dynamic>>> searchCustomers(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final dummyCustomers = [
      {
        'id': 'fake_cust_1',
        'name': 'John Doe',
        'number': '9876543210',
        'address': '123 Fake Street, City',
        'ro_type': 'Aquaguard RO',
      },
      {
        'id': 'fake_cust_2',
        'name': 'Jane Smith',
        'number': '9123456780',
        'address': '456 Mock Avenue, Town',
        'ro_type': 'Kent RO',
      },
    ];

    if (query.isEmpty) return dummyCustomers;

    final q = query.toLowerCase();
    return dummyCustomers.where((c) {
      final name = (c['name'] as String).toLowerCase();
      final phone = c['number'] as String;
      return name.contains(q) || phone.contains(q);
    }).toList();
  }
}
