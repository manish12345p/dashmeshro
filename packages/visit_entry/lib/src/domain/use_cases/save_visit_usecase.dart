import '../entities/visit_record.dart';
import '../repositories/visit_repository_interface.dart';

class SaveServiceUseCase {
  final IVisitEntryRepository repository;

  SaveServiceUseCase(this.repository);

  Future<void> call(VisitRecord entry, {double? emiAmountPerMonth}) async {
    return await repository.createVisitEntry(
      entry,
      emiAmountPerMonth: emiAmountPerMonth,
    );
  }
}
