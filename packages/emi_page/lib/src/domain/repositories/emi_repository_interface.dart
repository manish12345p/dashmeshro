import '../entities/emi_dashboard_data.dart';

abstract class EmiRepositoryInterface {
  Future<EmiDashboardData> getEmiDashboardData();
  Future<void> markAsPaid(String installmentId);
  Future<void> addPayment(
    String installmentId,
    double amountPaid, {
    String paymentMethod = 'Cash',
    String transactionRef = '',
    String notes = '',
    String recordedBy = '',
  });
  Future<List<PaymentRecord>> getPaymentHistory();
}
