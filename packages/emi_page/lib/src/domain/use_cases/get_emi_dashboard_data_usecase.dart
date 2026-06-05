import '../entities/emi_dashboard_data.dart';
import '../repositories/emi_repository_interface.dart';

class GetEmiDashboardDataUseCase {
  final EmiRepositoryInterface _repository;

  GetEmiDashboardDataUseCase(this._repository);

  Future<EmiDashboardData> call() async {
    return await _repository.getEmiDashboardData();
  }
}
