import '../entities/home_data.dart';
import '../repositories/home_repository_interface.dart';

class UpdateHomeDataUseCase {
  final IHomeRepository repository;

  UpdateHomeDataUseCase(this.repository);

  Future<void> call(HomeData data) async {
    return repository.updateHomeData(data);
  }
}
