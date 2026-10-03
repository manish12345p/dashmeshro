import 'dart:async';
import '../../domain/entities/emi_dashboard_data.dart';
import 'emi_remote_data_source.dart';

class FakeEmiRemoteDataSource implements IEmiRemoteDataSource {
  final List<ActiveInstallment> _installments = [
    ActiveInstallment(
      id: 'fake_emi_1',
      customerId: 'fake_cust_1',
      customerName: 'John Doe',
      customerPhone: '9876543210',
      vehicleDetails: '123 Fake Street',
      serviceName: 'fake_service_1',
      numberOfInstallments: 3,
      amount: 1500.0,
      totalAmount: 4500.0,
      dueDate: DateTime.now().add(const Duration(days: 5)).toIso8601String(),
      status: 'pending',
      avatarUrl: '',
    ),
    ActiveInstallment(
      id: 'fake_emi_2',
      customerId: 'fake_cust_2',
      customerName: 'Jane Smith',
      customerPhone: '9123456780',
      vehicleDetails: '456 Mock Avenue',
      serviceName: 'fake_service_2',
      numberOfInstallments: 5,
      amount: 2000.0,
      totalAmount: 10000.0,
      dueDate: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(), // Overdue
      status: 'overdue',
      avatarUrl: '',
    ),
  ];

  final List<PaymentRecord> _payments = [
    PaymentRecord(
      id: 'fake_payment_1',
      installmentId: 'fake_emi_0',
      customerId: 'fake_cust_1',
      customerName: 'John Doe',
      amount: 1500.0,
      dateStr: DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      paymentMethod: 'Cash',
      recordedBy: 'Admin',
      serviceName: 'fake_service_1',
      invoiceNumber: 'INV-001',
    ),
  ];

  @override
  Future<EmiDashboardData> getEmiDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return EmiDashboardData(
      totalOutstandingBalance: 12500.0,
      expectedMonthlyDemand: 3500.0,
      collectedThisMonth: 1500.0,
      overdueClientsCount: 1,
      pendingClientsCount: 1,
      paidThisMonthCount: 1,
      recentlyPaidInstallments: [
         RecentlyPaidInstallment(
           id: 'recent_1',
           customerId: 'fake_cust_1',
           customerName: 'John Doe',
           amount: 1500.0,
           paidDateStr: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
         ),
      ],
      activeInstallments: _installments,
    );
  }

  @override
  Future<void> markAsPaid(String installmentId) async {
    final index = _installments.indexWhere((i) => i.id == installmentId);
    if (index != -1) {
      final inst = _installments[index];
      
      _payments.add(
        PaymentRecord(
          id: 'fake_payment_${DateTime.now().millisecondsSinceEpoch}',
          installmentId: inst.id,
          customerId: inst.customerId,
          customerName: inst.customerName,
          amount: inst.amount,
          dateStr: DateTime.now().toIso8601String(),
          paymentMethod: 'System',
          recordedBy: 'Admin',
          serviceName: inst.serviceName,
          invoiceNumber: inst.invoiceNumber,
        ),
      );
    }
  }

  @override
  Future<void> addPayment(
    String installmentId,
    double amountPaid, {
    String paymentMethod = 'Cash',
    String transactionRef = '',
    String notes = '',
    String recordedBy = '',
  }) async {
    final index = _installments.indexWhere((i) => i.id == installmentId);
    if (index != -1) {
      final inst = _installments[index];
      
      _payments.add(
        PaymentRecord(
          id: 'fake_payment_${DateTime.now().millisecondsSinceEpoch}',
          installmentId: inst.id,
          customerId: inst.customerId,
          customerName: inst.customerName,
          amount: amountPaid,
          dateStr: DateTime.now().toIso8601String(),
          paymentMethod: paymentMethod,
          transactionRef: transactionRef,
          notes: notes,
          recordedBy: recordedBy,
          serviceName: inst.serviceName,
          invoiceNumber: inst.invoiceNumber,
        ),
      );
    }
  }

  @override
  Future<List<PaymentRecord>> getPaymentHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final sortedPayments = List<PaymentRecord>.from(_payments)
      ..sort((a, b) => b.dateStr.compareTo(a.dateStr));
    return sortedPayments;
  }
}
