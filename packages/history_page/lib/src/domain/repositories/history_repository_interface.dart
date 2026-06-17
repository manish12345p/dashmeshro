import '../entities/history_item.dart';

abstract class IHistoryRepository {
  Stream<List<HistoryItem>> getAllServices();
}
