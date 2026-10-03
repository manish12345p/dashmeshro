import 'dart:async';
import '../../domain/entities/customer.dart';
import 'customer_remote_data_source.dart';

class FakeCustomerRemoteDataSource implements ICustomerRemoteDataSource {
  final List<Customer> _customers = [
    const Customer(
      id: 'fake_cust_1',
      name: 'John Doe',
      customerId: 'CUST-001',
      number: '9876543210',
      address: '123 Fake Street, City',
      roType: 'Aquaguard RO',
      note: 'Fake customer notes',
    ),
    const Customer(
      id: 'fake_cust_2',
      name: 'Jane Smith',
      customerId: 'CUST-002',
      number: '9123456780',
      address: '456 Mock Avenue, Town',
      roType: 'Kent RO',
      note: '',
    ),
  ];

  final StreamController<List<Customer>> _controller = StreamController<List<Customer>>.broadcast();

  FakeCustomerRemoteDataSource() {
    _emit();
  }

  void _emit() {
    if (!_controller.isClosed) {
      _controller.add(List.unmodifiable(_customers));
    }
  }

  @override
  Stream<List<Customer>> getCustomers() async* {
    yield List.unmodifiable(_customers);
    yield* _controller.stream;
  }

  @override
  Stream<Customer> getCustomerById(String id) async* {
    final customer = _customers.firstWhere((c) => c.id == id, orElse: () => _customers.first);
    yield customer;
    yield* _controller.stream.map((list) => list.firstWhere((c) => c.id == id, orElse: () => customer));
  }

  @override
  Future<String> createCustomer(Customer customer) async {
    final newCustomer = customer.copyWith(id: 'fake_cust_${DateTime.now().millisecondsSinceEpoch}');
    _customers.add(newCustomer);
    _emit();
    return newCustomer.id!;
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    final index = _customers.indexWhere((c) => c.id == customer.id);
    if (index != -1) {
      _customers[index] = customer;
      _emit();
    }
  }

  @override
  Future<void> deleteCustomer(String id) async {
    _customers.removeWhere((c) => c.id == id);
    _emit();
  }

  @override
  Future<bool> checkCustomerExistsByPhone(String phone) async {
    return _customers.any((c) => c.number == phone);
  }
}
