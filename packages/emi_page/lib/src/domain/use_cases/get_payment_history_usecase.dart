import '../entities/emi_dashboard_data.dart';
import '../repositories/emi_repository_interface.dart';

class GetPaymentHistoryUseCase {
  final EmiRepositoryInterface repository;

  GetPaymentHistoryUseCase(this.repository);

  Future<List<PaymentRecord>> call() async {
    return await repository.getPaymentHistory();
  }
}
