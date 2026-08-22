import '../repositories/emi_repository_interface.dart';

class AddEmiPaymentUseCase {
  final EmiRepositoryInterface repository;

  AddEmiPaymentUseCase(this.repository);

  Future<void> call(
    String installmentId,
    double amount, {
    String paymentMethod = 'Cash',
    String transactionRef = '',
    String notes = '',
    String recordedBy = '',
  }) async {
    return await repository.addPayment(
      installmentId,
      amount,
      paymentMethod: paymentMethod,
      transactionRef: transactionRef,
      notes: notes,
      recordedBy: recordedBy,
    );
  }
}
