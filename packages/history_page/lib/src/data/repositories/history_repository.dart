import '../../domain/entities/history_item.dart';
import '../../domain/repositories/history_repository_interface.dart';
import '../datasources/history_remote_data_source.dart';

class HistoryRepository implements IHistoryRepository {
  final IHistoryRemoteDataSource remoteDataSource;

  HistoryRepository({required this.remoteDataSource});

  @override
  Stream<List<HistoryItem>> getAllServices() {
    return remoteDataSource.getAllServices();
  }
}
