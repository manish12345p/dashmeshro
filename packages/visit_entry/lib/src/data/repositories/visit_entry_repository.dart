import '../../domain/entities/visit_record.dart';
import '../../domain/repositories/visit_repository_interface.dart';
import '../datasources/visit_entry_remote_data_source.dart';

class VisitEntryRepository implements IVisitEntryRepository {
  final IVisitEntryRemoteDataSource remoteDataSource;

  VisitEntryRepository({required this.remoteDataSource});

  @override
  Future<void> createVisitEntry(
    VisitRecord entry, {
    double? emiAmountPerMonth,
    int? totalAmcVisitsToPurchase,
  }) async {
    return remoteDataSource.createVisitEntry(
      entry,
      emiAmountPerMonth: emiAmountPerMonth,
      totalAmcVisitsToPurchase: totalAmcVisitsToPurchase,
    );
  }

  @override
  Future<List<String>> getRoTypes() async {
    return remoteDataSource.getRoTypes();
  }

  @override
  Future<List<Map<String, dynamic>>> searchCustomers(String query) async {
    return remoteDataSource.searchCustomers(query);
  }
}
