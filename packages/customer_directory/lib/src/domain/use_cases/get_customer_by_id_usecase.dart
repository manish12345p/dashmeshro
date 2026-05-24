import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository_interface.dart';

class GetCustomerByIdUseCase {
  final ICustomerRepository _repository;

  GetCustomerByIdUseCase(this._repository);

  Stream<Customer> call(String id) {
    return _repository.getCustomerById(id);
  }
}
