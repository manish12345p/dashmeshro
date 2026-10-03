import 'dart:async';
import '../../domain/entities/emi_dashboard_data.dart';
import '../../domain/repositories/emi_repository_interface.dart';
import '../datasources/emi_remote_data_source.dart';

class EmiRepository implements EmiRepositoryInterface {
  final IEmiRemoteDataSource remoteDataSource;

  EmiRepository({required this.remoteDataSource});

  @override
  Future<EmiDashboardData> getEmiDashboardData() {
    return remoteDataSource.getEmiDashboardData();
  }

  @override
  Future<void> markAsPaid(String installmentId) {
    return remoteDataSource.markAsPaid(installmentId);
  }

  @override
  Future<void> addPayment(
    String installmentId,
    double amountPaid, {
    String paymentMethod = 'Cash',
    String transactionRef = '',
    String notes = '',
    String recordedBy = '',
  }) {
    return remoteDataSource.addPayment(
      installmentId,
      amountPaid,
      paymentMethod: paymentMethod,
      transactionRef: transactionRef,
      notes: notes,
      recordedBy: recordedBy,
    );
  }

  @override
  Future<List<PaymentRecord>> getPaymentHistory() {
    return remoteDataSource.getPaymentHistory();
  }
}
