import '../entities/home_data.dart';
import '../repositories/home_repository_interface.dart';

class CreateHomeDataUseCase {
  final IHomeRepository repository;

  CreateHomeDataUseCase(this.repository);

  Future<void> call(HomeData data) async {
    return repository.createHomeData(data);
  }
}
