import '../../domain/entities/customer.dart';

abstract class ICustomerRemoteDataSource {
  Stream<List<Customer>> getCustomers();
  Stream<Customer> getCustomerById(String id);
  Future<String> createCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> deleteCustomer(String id);
  Future<bool> checkCustomerExistsByPhone(String phone);
}
