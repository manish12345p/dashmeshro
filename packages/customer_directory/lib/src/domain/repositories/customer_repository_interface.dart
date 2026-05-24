import '../../domain/entities/customer.dart';

abstract class ICustomerRepository {
  Stream<List<Customer>> getCustomers();
  Stream<Customer> getCustomerById(String id);
}
