import '../entities/visit_record.dart';

abstract class IVisitEntryRepository {
  Future<void> createVisitEntry(
    VisitRecord entry, {
    double? emiAmountPerMonth,
    bool isRent = false,
    int? rentDueDay,
  });
  Future<List<String>> getRoTypes();
  Future<List<Map<String, dynamic>>> searchCustomers(String query);
}
