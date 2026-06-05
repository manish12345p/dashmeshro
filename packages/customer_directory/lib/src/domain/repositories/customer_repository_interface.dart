import '../../domain/entities/customer.dart';

abstract class ICustomerRepository {
  Stream<List<Customer>> getCustomers();
  Stream<Customer> getCustomerById(String id);
  Future<String> createCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> deleteCustomer(String id);
}
