import '../entities/emi_dashboard_data.dart';

abstract class EmiRepositoryInterface {
  Future<EmiDashboardData> getEmiDashboardData();
  Future<void> markAsPaid(String installmentId);
  Future<void> addPayment(String installmentId, double amountPaid);
}
