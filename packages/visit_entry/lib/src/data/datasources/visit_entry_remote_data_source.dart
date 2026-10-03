import '../../domain/entities/visit_record.dart';

abstract class IVisitEntryRemoteDataSource {
  Future<void> createVisitEntry(
    VisitRecord entry, {
    double? emiAmountPerMonth,
    int? totalAmcVisitsToPurchase,
  });

  Future<List<String>> getRoTypes();

  Future<List<Map<String, dynamic>>> searchCustomers(String query);
}
