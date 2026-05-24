import '../repositories/home_repository_interface.dart';

class DeleteHomeDataUseCase {
  final IHomeRepository repository;

  DeleteHomeDataUseCase(this.repository);

  Future<void> call(String id) async {
    return repository.deleteHomeData(id);
  }
}
