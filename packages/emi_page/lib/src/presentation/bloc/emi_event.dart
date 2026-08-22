import 'package:freezed_annotation/freezed_annotation.dart';

// removed part

abstract class EmiEvent {
  const EmiEvent();
}

class LoadDashboard extends EmiEvent {
  const LoadDashboard();
}

class FilterInstallments extends EmiEvent {
  final String status;
  const FilterInstallments(this.status);
}

class RemindCustomer extends EmiEvent {
  final String customerId;
  const RemindCustomer(this.customerId);
}

class MarkAsPaid extends EmiEvent {
  final String installmentId;
  const MarkAsPaid(this.installmentId);
}

class AddPayment extends EmiEvent {
  final String installmentId;
  final double amount;
  final String paymentMethod;
  final String transactionRef;
  final String notes;
  final String recordedBy;

  const AddPayment(
    this.installmentId,
    this.amount, {
    this.paymentMethod = 'Cash',
    this.transactionRef = '',
    this.notes = '',
    this.recordedBy = '',
  });
}

class SearchInstallments extends EmiEvent {
  final String query;
  const SearchInstallments(this.query);
}

class LoadPaymentHistory extends EmiEvent {
  const LoadPaymentHistory();
}
