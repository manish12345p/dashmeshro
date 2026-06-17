import '../entities/history_item.dart';
import '../repositories/history_repository_interface.dart';

class GetAllServicesUseCase {
  final IHistoryRepository repository;

  GetAllServicesUseCase(this.repository);

  Stream<List<HistoryItem>> execute() {
    return repository.getAllServices();
  }
}
