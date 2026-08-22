class GraphDataPoint {
  final String label;
  final double amount;

  const GraphDataPoint({required this.label, required this.amount});

  factory GraphDataPoint.fromJson(Map<String, dynamic> json) {
    return GraphDataPoint(
      label: json['label'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'amount': amount,
    };
  }
}

class EmiDashboardData {
  final double totalOutstandingBalance;
  final double expectedMonthlyDemand;
  final double collectedThisMonth;
  final int overdueClientsCount;
  final int pendingClientsCount;
  final int paidThisMonthCount;
  final List<RecentlyPaidInstallment> recentlyPaidInstallments;
  final List<ActiveInstallment> activeInstallments;
  final List<GraphDataPoint> dailyCollection;
  final List<GraphDataPoint> monthlyCollection;
  final List<GraphDataPoint> yearlyCollection;

  const EmiDashboardData({
    required this.totalOutstandingBalance,
    required this.expectedMonthlyDemand,
    required this.collectedThisMonth,
    required this.overdueClientsCount,
    required this.pendingClientsCount,
    required this.paidThisMonthCount,
    required this.recentlyPaidInstallments,
    required this.activeInstallments,
    this.dailyCollection = const [],
    this.monthlyCollection = const [],
    this.yearlyCollection = const [],
  });

  factory EmiDashboardData.fromJson(Map<String, dynamic> json) {
    return EmiDashboardData(
      totalOutstandingBalance: (json['totalOutstandingBalance'] as num?)?.toDouble() ?? 0.0,
      expectedMonthlyDemand: (json['expectedMonthlyDemand'] as num?)?.toDouble() ?? 0.0,
      collectedThisMonth: (json['collectedThisMonth'] as num?)?.toDouble() ?? 0.0,
      overdueClientsCount: json['overdueClientsCount'] as int? ?? 0,
      pendingClientsCount: json['pendingClientsCount'] as int? ?? 0,
      paidThisMonthCount: json['paidThisMonthCount'] as int? ?? 0,
      recentlyPaidInstallments: (json['recentlyPaidInstallments'] as List<dynamic>?)
              ?.map((e) => RecentlyPaidInstallment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      activeInstallments: (json['activeInstallments'] as List<dynamic>?)
              ?.map((e) => ActiveInstallment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      dailyCollection: (json['dailyCollection'] as List<dynamic>?)
              ?.map((e) => GraphDataPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      monthlyCollection: (json['monthlyCollection'] as List<dynamic>?)
              ?.map((e) => GraphDataPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      yearlyCollection: (json['yearlyCollection'] as List<dynamic>?)
              ?.map((e) => GraphDataPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class RecentlyPaidInstallment {
  final String id;
  final String customerId;
  final String customerName;
  final double amount;
  final String paidDateStr;

  const RecentlyPaidInstallment({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.amount,
    required this.paidDateStr,
  });

  factory RecentlyPaidInstallment.fromJson(Map<String, dynamic> json) {
    return RecentlyPaidInstallment(
      id: json['id'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      paidDateStr: json['paidDateStr'] as String? ?? '',
    );
  }
}

class ActiveInstallment {
  final String id;
  final String customerId;
  final String customerName;
  final String vehicleDetails;
  final double amount;
  final double totalAmount;
  final double originalLoanAmount;
  final String serviceName;
  final double lastPaymentAmount;
  final String lastPaymentDateStr;
  final String dueDate;
  final String status;
  final String avatarUrl;
  final bool isRent;
  final int? rentDueDay;
  final int numberOfInstallments;
  final int paidInstallmentsCount;
  final double downPayment;
  final String invoiceNumber;
  final String customerPhone;

  const ActiveInstallment({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.vehicleDetails,
    required this.amount,
    required this.totalAmount,
    this.originalLoanAmount = 0.0,
    this.serviceName = '',
    this.lastPaymentAmount = 0.0,
    this.lastPaymentDateStr = '',
    required this.dueDate,
    required this.status,
    required this.avatarUrl,
    this.isRent = false,
    this.rentDueDay,
    this.numberOfInstallments = 0,
    this.paidInstallmentsCount = 0,
    this.downPayment = 0.0,
    this.invoiceNumber = '',
    this.customerPhone = '',
  });

  factory ActiveInstallment.fromJson(Map<String, dynamic> json) {
    return ActiveInstallment(
      id: json['id'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      vehicleDetails: json['vehicleDetails'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      originalLoanAmount: (json['originalLoanAmount'] as num?)?.toDouble() ?? 0.0,
      serviceName: json['serviceName'] as String? ?? '',
      lastPaymentAmount: (json['lastPaymentAmount'] as num?)?.toDouble() ?? 0.0,
      lastPaymentDateStr: json['lastPaymentDateStr'] as String? ?? '',
      dueDate: json['dueDate'] as String? ?? '',
      status: json['status'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      isRent: json['isRent'] as bool? ?? false,
      rentDueDay: json['rentDueDay'] as int?,
      numberOfInstallments: json['numberOfInstallments'] as int? ?? 0,
      paidInstallmentsCount: json['paidInstallmentsCount'] as int? ?? 0,
      downPayment: (json['downPayment'] as num?)?.toDouble() ?? 0.0,
      invoiceNumber: json['invoiceNumber'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
    );
  }
}

class PaymentRecord {
  final String id;
  final String installmentId;
  final String customerId;
  final String customerName;
  final String serviceName;
  final String invoiceNumber;
  final double amount;
  final String dateStr;
  final String paymentMethod;
  final String transactionRef;
  final String recordedBy;
  final String notes;
  final double remainingBalanceAfter;
  final int installmentNumber;

  const PaymentRecord({
    required this.id,
    required this.installmentId,
    required this.customerId,
    required this.customerName,
    required this.serviceName,
    required this.invoiceNumber,
    required this.amount,
    required this.dateStr,
    this.paymentMethod = 'Cash',
    this.transactionRef = '',
    this.recordedBy = '',
    this.notes = '',
    this.remainingBalanceAfter = 0.0,
    this.installmentNumber = 0,
  });

  factory PaymentRecord.fromJson(Map<String, dynamic> json) {
    return PaymentRecord(
      id: json['id'] as String? ?? '',
      installmentId: json['installmentId'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      serviceName: json['serviceName'] as String? ?? '',
      invoiceNumber: json['invoiceNumber'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      dateStr: json['dateStr'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? 'Cash',
      transactionRef: json['transactionRef'] as String? ?? '',
      recordedBy: json['recordedBy'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      remainingBalanceAfter: (json['remainingBalanceAfter'] as num?)?.toDouble() ?? 0.0,
      installmentNumber: json['installmentNumber'] as int? ?? 0,
    );
  }
}
