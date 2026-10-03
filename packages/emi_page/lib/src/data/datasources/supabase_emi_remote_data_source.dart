import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/emi_dashboard_data.dart';
import 'emi_remote_data_source.dart';

/// Supabase implementation of [IEmiRemoteDataSource].
///
/// Table mapping:
///   installments          ← installments collection
///   payments              ← payments collection
///   emi_monthly_snapshots ← emi_monthly_snapshots collection
///   customers             ← Customer collection
class SupabaseEmiRemoteDataSource implements IEmiRemoteDataSource {
  final SupabaseClient _client;

  SupabaseEmiRemoteDataSource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  // ---------------------------------------------------------------------------
  @override
  Future<EmiDashboardData> getEmiDashboardData() async {
    try {
      final today = DateTime.now();
      final currentMonth = today.month;
      final currentYear = today.year;
      final monthKey = '$currentYear-${currentMonth.toString().padLeft(2, '0')}';

      // Fetch customers for phone lookup
      final custRows = await _client.from('customers').select('id, name, phone');
      final Map<String, String> nameToId = {};
      final Map<String, String> idToPhone = {};
      for (final r in custRows as List) {
        final row = r as Map<String, dynamic>;
        final name = row['name'] as String? ?? '';
        final phone = row['phone'] as String? ?? '';
        if (name.isNotEmpty) nameToId[name] = row['id'] as String;
        if (phone.isNotEmpty) idToPhone[row['id'] as String] = phone;
      }

      // Fetch all installments
      final instRows = await _client.from('installments').select();

      double totalOutstanding = 0;
      double expectedMonthly = 0;
      double collectedThisMonth = 0;
      int overdueCount = 0;
      int pendingCount = 0;
      final Set<String> paidCustomers = {};
      final List<RecentlyPaidInstallment> recentlyPaid = [];
      final List<ActiveInstallment> activeInst = [];

      final Map<String, double> monthlyMap = {};
      final Map<String, double> yearlyMap = {};
      final Map<String, double> dailyMap = {};

      for (final r in instRows as List) {
        final data = r as Map<String, dynamic>;
        final emiMonthly = (data['emi_monthly_amount'] as num? ?? data['amount'] as num? ?? 0).toDouble();
        final status = data['status'] as String? ?? 'pending';
        final amount = status == 'paid' ? emiMonthly : (data['amount'] as num? ?? 0).toDouble();
        final dueStr = data['due_date'] as String? ?? '';
        final customerName = data['customer_name'] as String? ?? 'Unknown';
        final customerId = data['customer_id'] as String? ?? nameToId[customerName] ?? '';
        final vehicleDetails = data['vehicle_details'] as String? ?? '';
        final totalAmount = (data['total_amount'] as num? ?? data['totalAmount'] as num? ?? 0).toDouble();
        final lastPayStr = data['last_payment_date'] as String? ?? data['paid_at'] as String? ?? '';
        final lastPayAmt = (data['last_payment_amount'] as num? ?? 0).toDouble();
        final isRent = data['is_rent'] as bool? ?? false;
        final rentDueDay = data['rent_due_day'] as int?;

        if (amount <= 0 && totalAmount <= 0 && status != 'paid' && !isRent) continue;

        DateTime? dueDate;
        try { if (dueStr.isNotEmpty) dueDate = DateTime.parse(dueStr); } catch (_) {}
        DateTime? lastPayDate;
        try { if (lastPayStr.isNotEmpty) lastPayDate = DateTime.parse(lastPayStr); } catch (_) {}

        final paidThisMonth = lastPayDate != null && lastPayDate.month == currentMonth && lastPayDate.year == currentYear;

        String effectiveStatus;
        if (isRent) {
          final dueDay = rentDueDay ?? 1;
          if (paidThisMonth) {
            effectiveStatus = 'paid_this_month';
          } else if (today.day > dueDay) {
            effectiveStatus = 'overdue';
          } else {
            effectiveStatus = 'pending';
          }
        } else {
          if (status == 'paid') {
            effectiveStatus = 'paid';
          } else if (paidThisMonth) {
            effectiveStatus = 'paid_this_month';
          } else if (status == 'overdue') {
            effectiveStatus = 'overdue';
          } else if (dueDate == null) {
            effectiveStatus = 'overdue';
          } else if (dueDate.isBefore(DateTime(today.year, today.month, today.day))) {
            effectiveStatus = 'overdue';
          } else {
            effectiveStatus = 'pending';
          }
        }

        double originalLoan = (data['original_loan_amount'] as num? ?? totalAmount).toDouble();
        if (originalLoan == 0) originalLoan = totalAmount;

        String serviceName = data['service_name'] as String? ?? '';
        final serviceId = data['service_id'] as String?;
        if (serviceName.isEmpty) {
          serviceName = (serviceId != null && serviceId.length >= 5) ? 'Service #${serviceId.substring(0, 5)}' : 'Service';
        }

        double totalPaid = 0;
        int paidCount = 0;
        final monthlyPayments = data['monthly_payments'] as Map<String, dynamic>?;
        if (monthlyPayments != null && monthlyPayments.isNotEmpty) {
          for (final e in monthlyPayments.entries) {
            final amt = (e.value as num).toDouble();
            totalPaid += amt;
            paidCount++;
            monthlyMap[e.key] = (monthlyMap[e.key] ?? 0) + amt;
            if (e.key.length >= 4) {
              final y = e.key.substring(0, 4);
              yearlyMap[y] = (yearlyMap[y] ?? 0) + amt;
            }
          }
        } else if (lastPayAmt > 0) {
          totalPaid = lastPayAmt;
          paidCount = 1;
        }

        if (lastPayDate != null && lastPayAmt > 0) {
          final dKey = lastPayDate.toIso8601String().substring(0, 10);
          dailyMap[dKey] = (dailyMap[dKey] ?? 0) + lastPayAmt;
        }

        if (effectiveStatus != 'paid') {
          final remaining = totalAmount - totalPaid;
          if (remaining > 0) totalOutstanding += remaining;
          expectedMonthly += emiMonthly;
        }

        if (monthlyPayments != null && monthlyPayments.containsKey(monthKey)) {
          collectedThisMonth += (monthlyPayments[monthKey] as num).toDouble();
        } else if (paidThisMonth) {
          collectedThisMonth += lastPayAmt;
        }

        if (effectiveStatus == 'overdue') {
          overdueCount++;
        } else if (effectiveStatus == 'pending') {
          pendingCount++;
        }

        if (paidThisMonth) {
          if (customerId.isNotEmpty) paidCustomers.add(customerId);
          if (recentlyPaid.length < 5) {
            final fd = '${lastPayDate!.day}/${lastPayDate.month}/${lastPayDate.year}';
            recentlyPaid.add(RecentlyPaidInstallment(
              id: data['id'] as String? ?? '',
              customerId: customerId,
              customerName: customerName,
              amount: lastPayAmt,
              paidDateStr: 'Paid on $fd',
            ));
          }
        }

        activeInst.add(ActiveInstallment(
          id: data['id'] as String? ?? '',
          customerId: customerId,
          customerName: customerName,
          vehicleDetails: vehicleDetails,
          amount: amount,
          totalAmount: totalAmount,
          originalLoanAmount: originalLoan,
          serviceName: serviceName,
          lastPaymentAmount: lastPayAmt,
          lastPaymentDateStr: lastPayStr,
          dueDate: dueStr,
          status: effectiveStatus,
          avatarUrl: data['avatar_url'] as String? ?? '',
          isRent: isRent,
          rentDueDay: rentDueDay,
          numberOfInstallments: data['number_of_installments'] as int? ?? 0,
          paidInstallmentsCount: paidCount,
          downPayment: (data['down_payment'] as num? ?? 0).toDouble(),
          invoiceNumber: data['id'] as String? ?? '',
          customerPhone: data['customer_phone'] as String? ?? idToPhone[customerId] ?? '',
        ));
      }

      // Fetch daily payments
      try {
        final pRows = await _client
            .from('payments')
            .select('date, amount')
            .gte('date', DateTime.now().subtract(const Duration(days: 30)).toIso8601String());
        for (final r in pRows as List) {
          final row = r as Map<String, dynamic>;
          final d = row['date'] as String? ?? '';
          final a = (row['amount'] as num? ?? 0).toDouble();
          if (d.length >= 10) dailyMap[d.substring(0, 10)] = (dailyMap[d.substring(0, 10)] ?? 0) + a;
        }
      } catch (_) {}

      List<GraphDataPoint> toPoints(Map<String, double> map, {int? limit}) {
        final sorted = map.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
        var pts = sorted.map((e) => GraphDataPoint(label: e.key, amount: e.value)).toList();
        if (limit != null && pts.length > limit) pts = pts.sublist(pts.length - limit);
        return pts;
      }

      activeInst.sort((a, b) {
        final da = DateTime.tryParse(a.dueDate) ?? DateTime.now();
        final db = DateTime.tryParse(b.dueDate) ?? DateTime.now();
        return da.compareTo(db);
      });

      return EmiDashboardData(
        totalOutstandingBalance: totalOutstanding,
        expectedMonthlyDemand: expectedMonthly,
        collectedThisMonth: collectedThisMonth,
        overdueClientsCount: overdueCount,
        pendingClientsCount: pendingCount,
        paidThisMonthCount: paidCustomers.length,
        recentlyPaidInstallments: recentlyPaid,
        activeInstallments: activeInst,
        dailyCollection: toPoints(dailyMap, limit: 14),
        monthlyCollection: toPoints(monthlyMap, limit: 12),
        yearlyCollection: toPoints(yearlyMap),
      );
    } catch (e) {
      throw Exception('Failed to load EMI dashboard data: $e');
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> markAsPaid(String installmentId) async {
    final row = await _client.from('installments').select('amount').eq('id', installmentId).maybeSingle();
    if (row == null) return;
    final amount = (row['amount'] as num? ?? 0).toDouble();
    await addPayment(installmentId, amount);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> addPayment(
    String installmentId,
    double amountPaid, {
    String paymentMethod = 'Cash',
    String transactionRef = '',
    String notes = '',
    String recordedBy = '',
  }) async {
    try {
      final row = await _client.from('installments').select().eq('id', installmentId).single();
      final data = row as Map<String, dynamic>;

      final currentTotal = (data['total_amount'] as num? ?? data['totalAmount'] as num? ?? data['amount'] as num? ?? 0).toDouble();
      final emiMonthly = (data['emi_monthly_amount'] as num? ?? data['amount'] as num? ?? currentTotal).toDouble();
      final newTotal = currentTotal - amountPaid;
      final isRent = data['is_rent'] as bool? ?? false;

      final monthKey = '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';
      final monthlyPayments = data['monthly_payments'] != null
          ? Map<String, dynamic>.from(data['monthly_payments'] as Map)
          : <String, dynamic>{};
      final curMonthPaid = (monthlyPayments[monthKey] as num? ?? 0).toDouble();
      monthlyPayments[monthKey] = curMonthPaid + amountPaid;
      final instNumber = monthlyPayments.keys.length;

      final Map<String, dynamic> updateData;
      if (newTotal <= 0 && !isRent) {
        updateData = {
          'status': 'paid',
          'paid_at': DateTime.now().toIso8601String(),
          'last_payment_date': DateTime.now().toIso8601String(),
          'total_amount': 0.0,
          'amount': 0.0,
          'last_payment_amount': amountPaid,
          'monthly_payments': monthlyPayments,
        };
      } else {
        DateTime currentDue = DateTime.now();
        try { if (data['due_date'] != null) currentDue = DateTime.parse(data['due_date'] as String); } catch (_) {}
        final nextDue = DateTime(currentDue.year, currentDue.month + 1, currentDue.day);
        final nextMonthly = (!isRent && newTotal < emiMonthly) ? newTotal : emiMonthly;
        updateData = {
          'total_amount': isRent ? 999999.0 : newTotal,
          'amount': nextMonthly,
          'emi_monthly_amount': emiMonthly,
          'due_date': nextDue.toIso8601String(),
          'last_payment_date': DateTime.now().toIso8601String(),
          'last_payment_amount': amountPaid,
          'status': 'pending',
          'monthly_payments': monthlyPayments,
        };
      }

      await _client.from('installments').update(updateData).eq('id', installmentId);

      // Payment record
      final payId = '${installmentId}_pay_${DateTime.now().millisecondsSinceEpoch}';
      final payData = {
        'id': payId,
        'installment_id': installmentId,
        'amount': amountPaid,
        'date': DateTime.now().toIso8601String(),
        'payment_method': paymentMethod,
        'transaction_ref': transactionRef,
        'recorded_by': recordedBy,
        'notes': notes,
        'remaining_balance_after': isRent ? 999999.0 : newTotal,
        'installment_number': instNumber,
      };
      await _client.from('payment_records').insert(payData);
      await _client.from('payments').insert(payData);

      // Update linked service
      final serviceId = data['service_id'] as String?;
      final customerId = data['customer_id'] as String?;
      if (serviceId != null && customerId != null && customerId.isNotEmpty) {
        final svcRow = await _client.from('services').select('amount_paid, amount_pending').eq('id', serviceId).maybeSingle();
        if (svcRow != null) {
          final curPaid = (svcRow['amount_paid'] as num? ?? 0).toDouble();
          final curPending = (svcRow['amount_pending'] as num? ?? 0).toDouble();
          await _client.from('services').update({
            'amount_paid': curPaid + amountPaid,
            'amount_pending': (curPending - amountPaid).clamp(0, double.infinity),
          }).eq('id', serviceId);
        }
      }
    } catch (e) {
      throw Exception('Failed to add payment: $e');
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Future<List<PaymentRecord>> getPaymentHistory() async {
    try {
      final rows = await _client.from('payment_records').select();
      final instRows = await _client.from('installments').select('id, customer_id, customer_name, service_name');
      final instMap = <String, Map<String, dynamic>>{
        for (final r in instRows as List) (r as Map<String, dynamic>)['id'] as String: r
      };

      final history = (rows as List<dynamic>).map((r) {
        final data = r as Map<String, dynamic>;
        final instId = data['installment_id'] as String? ?? '';
        final inst = instMap[instId];
        return PaymentRecord(
          id: data['id'] as String? ?? '',
          installmentId: instId,
          customerId: inst?['customer_id'] as String? ?? '',
          customerName: inst?['customer_name'] as String? ?? 'Unknown',
          serviceName: inst?['service_name'] as String? ?? '',
          invoiceNumber: instId,
          amount: (data['amount'] as num? ?? 0).toDouble(),
          dateStr: data['date'] as String? ?? '',
          paymentMethod: data['payment_method'] as String? ?? 'Cash',
          transactionRef: data['transaction_ref'] as String? ?? '',
          recordedBy: data['recorded_by'] as String? ?? '',
          notes: data['notes'] as String? ?? '',
          remainingBalanceAfter: (data['remaining_balance_after'] as num? ?? 0).toDouble(),
          installmentNumber: data['installment_number'] as int? ?? 0,
        );
      }).toList();

      history.sort((a, b) {
        final da = DateTime.tryParse(a.dateStr) ?? DateTime.fromMillisecondsSinceEpoch(0);
        final db = DateTime.tryParse(b.dateStr) ?? DateTime.fromMillisecondsSinceEpoch(0);
        return db.compareTo(da);
      });
      return history;
    } catch (_) {
      return [];
    }
  }
}
