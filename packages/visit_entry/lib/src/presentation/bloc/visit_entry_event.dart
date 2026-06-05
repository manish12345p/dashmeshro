import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_entry_event.freezed.dart';

@freezed
class VisitEntryEvent with _$VisitEntryEvent {
  const factory VisitEntryEvent.selectCustomer(String id, String name) =
      SelectCustomer;
  const factory VisitEntryEvent.selectServiceType(String type) =
      SelectServiceType;
  const factory VisitEntryEvent.toggleUrgency(bool isUrgent) = ToggleUrgency;
  const factory VisitEntryEvent.updateRemarks(String remarks) = UpdateRemarks;
  const factory VisitEntryEvent.updateFixes(String fixes) = UpdateFixes;
  const factory VisitEntryEvent.updateAmountPaid(double amount) =
      UpdateAmountPaid;
  const factory VisitEntryEvent.updateAmountPending(double amount) =
      UpdateAmountPending;
  const factory VisitEntryEvent.updateTotalAmount(double amount) =
      UpdateTotalAmount;
  const factory VisitEntryEvent.updateEquipmentsUsed(String equipments) =
      UpdateEquipmentsUsed;
  const factory VisitEntryEvent.updateServiceDuration(String duration) =
      UpdateServiceDuration;
  const factory VisitEntryEvent.updateGuaranteeDuration(String duration) =
      UpdateGuaranteeDuration;
  const factory VisitEntryEvent.updateEmiAmountPerMonth(double? amount) =
      UpdateEmiAmountPerMonth;
  const factory VisitEntryEvent.setDate(String date) = SetDate;
  const factory VisitEntryEvent.submit() = SubmitVisitEntry;
}
