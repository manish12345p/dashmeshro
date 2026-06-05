import '../entities/visit_record.dart';
import '../repositories/visit_repository_interface.dart';

class SaveServiceUseCase {
  final IVisitEntryRepository repository;

  SaveServiceUseCase(this.repository);

  Future<void> call(VisitRecord entry, {double? emiAmountPerMonth, int? totalAmcVisitsToPurchase}) async {
    return await repository.createVisitEntry(
      entry,
      emiAmountPerMonth: emiAmountPerMonth,
      totalAmcVisitsToPurchase: totalAmcVisitsToPurchase,
    );
  }
}
