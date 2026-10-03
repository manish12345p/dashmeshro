import '../../domain/entities/history_item.dart';

abstract class IHistoryRemoteDataSource {
  Stream<List<HistoryItem>> getAllServices();
}
