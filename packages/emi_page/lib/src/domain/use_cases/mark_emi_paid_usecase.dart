import '../repositories/emi_repository_interface.dart';

class MarkEmiPaidUseCase {
  final EmiRepositoryInterface repository;

  MarkEmiPaidUseCase(this.repository);

  Future<void> call(String installmentId) async {
    return await repository.markAsPaid(installmentId);
  }
}
