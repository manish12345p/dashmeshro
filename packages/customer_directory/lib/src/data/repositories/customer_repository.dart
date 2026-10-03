import 'dart:async';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository_interface.dart';
import '../datasources/customer_remote_data_source.dart';

class CustomerRepository implements ICustomerRepository {
  final ICustomerRemoteDataSource remoteDataSource;

  CustomerRepository({required this.remoteDataSource});

  @override
  Stream<List<Customer>> getCustomers() {
    return remoteDataSource.getCustomers();
  }

  @override
  Stream<Customer> getCustomerById(String id) {
    return remoteDataSource.getCustomerById(id);
  }

  @override
  Future<String> createCustomer(Customer customer) {
    return remoteDataSource.createCustomer(customer);
  }

  @override
  Future<void> updateCustomer(Customer customer) {
    return remoteDataSource.updateCustomer(customer);
  }

  @override
  Future<void> deleteCustomer(String id) {
    return remoteDataSource.deleteCustomer(id);
  }

  @override
  Future<bool> checkCustomerExistsByPhone(String phone) {
    return remoteDataSource.checkCustomerExistsByPhone(phone);
  }
}
