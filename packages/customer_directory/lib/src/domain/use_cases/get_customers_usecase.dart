import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository_interface.dart';

class GetCustomersUseCase {
  final ICustomerRepository _repository;

  GetCustomersUseCase(this._repository);

  Stream<List<Customer>> call() {
    return _repository.getCustomers();
  }
}
