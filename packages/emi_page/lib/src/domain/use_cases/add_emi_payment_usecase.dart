import '../repositories/emi_repository_interface.dart';

class AddEmiPaymentUseCase {
  final EmiRepositoryInterface repository;

  AddEmiPaymentUseCase(this.repository);

  Future<void> call(String installmentId, double amount) async {
    return await repository.addPayment(installmentId, amount);
  }
}
