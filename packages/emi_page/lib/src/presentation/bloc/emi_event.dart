import 'package:freezed_annotation/freezed_annotation.dart';

part 'emi_event.freezed.dart';

@freezed
class EmiEvent with _$EmiEvent {
  const factory EmiEvent.loadDashboard() = LoadDashboard;
  const factory EmiEvent.filterInstallments(String status) = FilterInstallments;
  const factory EmiEvent.remindCustomer(String customerId) = RemindCustomer;
  const factory EmiEvent.markAsPaid(String installmentId) = MarkAsPaid;
  const factory EmiEvent.addPayment(String installmentId, double amount) = AddPayment;
}
