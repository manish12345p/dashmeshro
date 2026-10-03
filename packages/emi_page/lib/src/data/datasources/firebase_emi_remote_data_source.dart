import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/emi_dashboard_data.dart';
import 'emi_remote_data_source.dart';

class FirebaseEmiRemoteDataSource implements IEmiRemoteDataSource {
  final FirebaseFirestore? _firestore;

  FirebaseEmiRemoteDataSource({FirebaseFirestore? firestore}) : _firestore = firestore;

  FirebaseFirestore get firestore => _firestore ?? FirebaseFirestore.instance;

  @override
  Future<EmiDashboardData> getEmiDashboardData() async {
    if (_firestore == null && Firebase.apps.isEmpty) {
      return _getInitialMockData();
    }

    try {
      final snapshotMonthYear =
          '${DateTime.now().year}_${DateTime.now().month.toString().padLeft(2, '0')}';
      final snapshotDoc = firestore
          .collection('emi_monthly_snapshots')
          .doc(snapshotMonthYear);
      final snapshotData = await snapshotDoc.get();

      double totalExpectedThisMonth = 0;
      bool saveNewSnapshot = false;
      if (snapshotData.exists) {
        totalExpectedThisMonth =
            (snapshotData.data()!['totalExpected'] as num?)?.toDouble() ?? 0.0;
      } else {
        saveNewSnapshot = true;
      }

      final snapshot = await firestore.collection('installments').get();

      double totalOutstandingBalance = 0.0;
      double expectedMonthlyDemand = 0.0;
      double collectedThisMonth = 0.0;
      int overdueClientsCount = 0;
      int pendingClientsCount = 0;
      Set<String> customersPaidThisMonth = {};
      List<RecentlyPaidInstallment> recentlyPaidInstallments = [];
      List<ActiveInstallment> activeInstallments = [];

      final today = DateTime.now();
      final currentMonth = today.month;
      final currentYear = today.year;

      // Fetch customers to map name -> id and id -> phone
      final customerSnap = await firestore.collection('Customer').get();
      final Map<String, String> nameToIdMap = {};
      final Map<String, String> idToPhoneMap = {};
      for (var c in customerSnap.docs) {
        final name = c.data()['name'] as String? ?? '';
        final phone = c.data()['number'] as String? ?? c.data()['phone_number'] as String? ?? c.data()['phone'] as String? ?? '';
        if (name.isNotEmpty) {
          nameToIdMap[name] = c.id;
        }
        if (phone.isNotEmpty) {
          idToPhoneMap[c.id] = phone;
        }
      }

      final Map<String, double> monthlyMap = {};
      final Map<String, double> yearlyMap = {};
      final Map<String, double> fallbackDailyMap = {};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final emiMonthlyAmount =
            (data['emi_monthly_amount'] as num?)?.toDouble() ??
            (data['amount'] as num?)?.toDouble() ??
            0.0;
        final status = data['status'] as String? ?? 'pending';
        final amount = (status == 'paid')
            ? emiMonthlyAmount
            : ((data['amount'] as num?)?.toDouble() ?? 0.0);
        final dueDateStr = data['due_date'] as String? ?? '';
        final customerName = data['customer_name'] as String? ?? 'Unknown';
        final customerId =
            data['customer_id'] as String? ?? nameToIdMap[customerName] ?? '';
        final vehicleDetails = data['vehicle_details'] as String? ?? '';
        // Use snake_case consistently for Firestore field names
        final totalAmount =
            (data['total_amount'] as num?)?.toDouble() ??
            (data['totalAmount'] as num?)?.toDouble() ??
            0.0;
        final lastPaymentDateStr =
            data['last_payment_date'] as String? ??
            data['paid_at'] as String? ??
            '';
        final lastPaymentAmount =
            (data['last_payment_amount'] as num?)?.toDouble() ?? 0.0;
        final isRent = data['is_rent'] as bool? ?? false;
        final rentDueDay = data['rent_due_day'] as int?;

        // Skip completely empty/invalid records (but do NOT delete them)
        if (amount <= 0 && totalAmount <= 0 && status != 'paid' && !isRent) {
          continue;
        }

        DateTime? dueDate;
        try {
          if (dueDateStr.isNotEmpty) dueDate = DateTime.parse(dueDateStr);
        } catch (_) {}

        DateTime? lastPaymentDate;
        try {
          if (lastPaymentDateStr.isNotEmpty) {
            lastPaymentDate = DateTime.parse(lastPaymentDateStr);
          }
        } catch (_) {}

        // Determine effective status
        final bool paidThisMonth =
            lastPaymentDate != null &&
            lastPaymentDate.month == currentMonth &&
            lastPaymentDate.year == currentYear;

        String effectiveStatus;
        if (isRent) {
          final effectiveRentDueDay = rentDueDay ?? 1; // Default to 1st of month if missing
          if (paidThisMonth) {
            effectiveStatus = 'paid_this_month';
          } else if (today.day > effectiveRentDueDay) {
            effectiveStatus = 'overdue';
          } else {
            effectiveStatus = 'pending';
          }
        } else {
          if (status == 'paid') {
            // Fully paid off (total_amount == 0)
            effectiveStatus = 'paid';
          } else if (paidThisMonth) {
            // They made a payment this month -> Paid this month (overrides overdue)
            effectiveStatus = 'paid_this_month';
          } else if (status == 'overdue') {
            // It was explicitly marked as overdue in the database
            effectiveStatus = 'overdue';
          } else if (dueDate == null) {
            // No due date, not paid this month, not fully paid -> Overdue
            effectiveStatus = 'overdue';
          } else if (dueDate.isBefore(DateTime(today.year, today.month, today.day))) {
            // Due date is in the past -> Overdue!
            effectiveStatus = 'overdue';
          } else {
            effectiveStatus = 'pending';
          }
        }

        double originalLoanAmount =
            (data['original_loan_amount'] as num?)?.toDouble() ?? 0.0;
        String serviceName = data['service_name'] as String? ?? '';
        final serviceId = data['service_id'] as String?;

        if (originalLoanAmount == 0.0) {
          originalLoanAmount = totalAmount; // Fallback
        }
        if (serviceName.isEmpty) {
          if (serviceId != null && serviceId.length >= 5) {
            serviceName = 'Service #${serviceId.substring(0, 5)}';
          } else {
            serviceName = 'Service';
          }
        }

        // --- NEW Dashboard Aggregation ---

        // Lifetime collection calculation
        double totalPaidForInstallment = 0;
        int paidInstallmentsCount = 0;
        final monthKey = '$currentYear-${currentMonth.toString().padLeft(2, '0')}';
        final monthlyPayments = data['monthly_payments'] as Map<String, dynamic>?;

        if (monthlyPayments != null && monthlyPayments.isNotEmpty) {
          for (var entry in monthlyPayments.entries) {
            String mKey = entry.key;
            double amt = (entry.value as num).toDouble();
            
            totalPaidForInstallment += amt;
            paidInstallmentsCount++;
            
            // Build Graph Maps
            monthlyMap[mKey] = (monthlyMap[mKey] ?? 0) + amt;
            if (mKey.length >= 4) {
              String yKey = mKey.substring(0, 4);
              yearlyMap[yKey] = (yearlyMap[yKey] ?? 0) + amt;
            }
          }
        } else if (lastPaymentAmount > 0) {
          totalPaidForInstallment = lastPaymentAmount;
          paidInstallmentsCount = 1;
        }
        
        if (lastPaymentDate != null && lastPaymentAmount > 0) {
           String dKey = lastPaymentDate.toIso8601String().substring(0, 10);
           fallbackDailyMap[dKey] = (fallbackDailyMap[dKey] ?? 0) + lastPaymentAmount;
        }

        // Calculate Outstanding Balance
        if (effectiveStatus != 'paid') {
          double remainingBalance = totalAmount - totalPaidForInstallment;
          if (remainingBalance > 0) {
            totalOutstandingBalance += remainingBalance;
          }
          // Monthly Demand
          expectedMonthlyDemand += emiMonthlyAmount;
        }

        // Collected This Month
        if (monthlyPayments != null && monthlyPayments.containsKey(monthKey)) {
          collectedThisMonth += (monthlyPayments[monthKey] as num).toDouble();
        } else if (paidThisMonth) {
          collectedThisMonth += lastPaymentAmount;
        }

        // Client Status Counters
        if (effectiveStatus == 'overdue') {
          overdueClientsCount++;
        } else if (effectiveStatus == 'pending') {
          pendingClientsCount++;
        }

        if (paidThisMonth) {
          if (customerId.isNotEmpty) customersPaidThisMonth.add(customerId);

          if (recentlyPaidInstallments.length < 5) {
            final date = lastPaymentDate;
            final formattedDate = '${date!.day}/${date.month}/${date.year}';
            recentlyPaidInstallments.add(
              RecentlyPaidInstallment(
                id: data['id'] as String? ?? doc.id,
                customerId: customerId,
                customerName: customerName,
                amount: lastPaymentAmount,
                paidDateStr: 'Paid on $formattedDate',
              ),
            );
          }
        }

        final numberOfInstallments = data['number_of_installments'] as int? ?? 0;
        // In this system, down payment is technically the amountCharged - amountPending at the time of creation.
        // We can approximate it if we know the original loan amount.
        // But for now, we leave it at 0 if not stored, as we don't have it directly.
        final downPayment = (data['down_payment'] as num?)?.toDouble() ?? 0.0;
        final invoiceNumber = doc.id;
        final customerPhone = data['customer_phone'] as String? ?? idToPhoneMap[customerId] ?? '';

        activeInstallments.add(
          ActiveInstallment(
            id: data['id'] as String? ?? doc.id,
            customerId: customerId,
            customerName: customerName,
            vehicleDetails: vehicleDetails,
            amount: amount,
            totalAmount: totalAmount,
            originalLoanAmount: originalLoanAmount,
            serviceName: serviceName,
            lastPaymentAmount: lastPaymentAmount,
            lastPaymentDateStr: lastPaymentDateStr,
            dueDate: dueDateStr,
            status: effectiveStatus,
            avatarUrl: data['avatar_url'] as String? ?? '',
            isRent: isRent,
            rentDueDay: rentDueDay,
            numberOfInstallments: numberOfInstallments,
            paidInstallmentsCount: paidInstallmentsCount,
            downPayment: downPayment,
            invoiceNumber: invoiceNumber,
            customerPhone: customerPhone,
          ),
        );
      }

      if (saveNewSnapshot) {
        await snapshotDoc.set({'totalExpected': totalExpectedThisMonth});
      }
      
      // --- Fetch Daily Graph Data from new collection ---
      Map<String, double> dailyMap = {};
      try {
        final paymentsSnap = await firestore.collection('payments')
          .where('date', isGreaterThanOrEqualTo: DateTime.now().subtract(const Duration(days: 30)).toIso8601String())
          .get();
          
        for (var pDoc in paymentsSnap.docs) {
          final pData = pDoc.data();
          final pDateStr = pData['date'] as String? ?? '';
          final pAmt = (pData['amount'] as num?)?.toDouble() ?? 0.0;
          if (pDateStr.length >= 10) { 
            String dKey = pDateStr.substring(0, 10);
            dailyMap[dKey] = (dailyMap[dKey] ?? 0) + pAmt;
          }
        }
      } catch (e) {
        // Ignore index errors if query fails initially
      }
      
      if (dailyMap.isEmpty) {
        dailyMap = fallbackDailyMap;
      }
      
      List<GraphDataPoint> convertMapToList(Map<String, double> map, {int? limit}) {
        final entries = map.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        List<GraphDataPoint> points = entries.map((e) => GraphDataPoint(label: e.key, amount: e.value)).toList();
        if (limit != null && points.length > limit) {
           points = points.sublist(points.length - limit);
        }
        return points;
      }

      // Sort active installments by due date (oldest first for overdue prioritization)
      activeInstallments.sort((a, b) {
        final dateA = DateTime.tryParse(a.dueDate) ?? DateTime.now();
        final dateB = DateTime.tryParse(b.dueDate) ?? DateTime.now();
        return dateA.compareTo(dateB);
      });

      int paidThisMonthCount = customersPaidThisMonth.length;

      return EmiDashboardData(
        totalOutstandingBalance: totalOutstandingBalance,
        expectedMonthlyDemand: expectedMonthlyDemand,
        collectedThisMonth: collectedThisMonth,
        overdueClientsCount: overdueClientsCount,
        pendingClientsCount: pendingClientsCount,
        paidThisMonthCount: paidThisMonthCount,
        recentlyPaidInstallments: recentlyPaidInstallments,
        activeInstallments: activeInstallments,
        dailyCollection: convertMapToList(dailyMap, limit: 14),
        monthlyCollection: convertMapToList(monthlyMap, limit: 12),
        yearlyCollection: convertMapToList(yearlyMap),
      );
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
  }

  @override
  Future<void> markAsPaid(String installmentId) async {
    try {
      final docRef = firestore.collection('installments').doc(installmentId);
      final doc = await docRef.get();
      if (!doc.exists) return;

      final data = doc.data()!;
      final amount = (data['amount'] as num?)?.toDouble() ?? 0.0;

      // Pay this month's EMI amount
      await addPayment(installmentId, amount);
    } catch (e) {
      throw Exception('Failed to mark as paid: $e');
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
    try {
      await firestore.runTransaction((transaction) async {
        final docRef = firestore.collection('installments').doc(installmentId);
        final doc = await transaction.get(docRef);
        if (!doc.exists) return;

        final data = doc.data()!;
        // Read total_amount (snake_case) with fallback to totalAmount (camelCase)
        final currentTotalAmount =
            (data['total_amount'] as num?)?.toDouble() ??
            (data['totalAmount'] as num?)?.toDouble() ??
            (data['amount'] as num?)?.toDouble() ??
            0.0;
        final emiMonthlyAmount =
            (data['emi_monthly_amount'] as num?)?.toDouble() ??
            (data['amount'] as num?)?.toDouble() ??
            currentTotalAmount;

        final newTotalAmount = currentTotalAmount - amountPaid;

        final monthKey =
            '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';
        final monthlyPayments = data['monthly_payments'] != null
            ? Map<String, dynamic>.from(data['monthly_payments'] as Map)
            : <String, dynamic>{};

        double currentMonthPaid =
            (monthlyPayments[monthKey] as num?)?.toDouble() ?? 0.0;

        if (currentMonthPaid == 0.0) {
          try {
            final lpdStr =
                data['last_payment_date'] as String? ??
                data['paid_at'] as String? ??
                '';
            if (lpdStr.isNotEmpty) {
              final lpd = DateTime.parse(lpdStr);
              if (lpd.month == DateTime.now().month &&
                  lpd.year == DateTime.now().year) {
                currentMonthPaid =
                    (data['last_payment_amount'] as num?)?.toDouble() ?? 0.0;
              }
            }
          } catch (_) {}
        }

        monthlyPayments[monthKey] = currentMonthPaid + amountPaid;
        final installmentNumber = monthlyPayments.keys.length;

        final isRent = data['is_rent'] as bool? ?? false;
        final rentDueDay = data['rent_due_day'] as int?;

        if (newTotalAmount <= 0 && !isRent) {
          // Fully paid — no more installments
          transaction.update(docRef, {
            'status': 'paid',
            'paid_at': DateTime.now().toIso8601String(),
            'last_payment_date': DateTime.now().toIso8601String(),
            'total_amount': 0.0,
            'amount': 0.0,
            'last_payment_amount': amountPaid,
            'monthly_payments': monthlyPayments,
          });
        } else {
          // Partial payment — advance due date by 1 calendar month
          DateTime currentDueDate = DateTime.now();
          try {
            if (data['due_date'] != null) {
              currentDueDate = DateTime.parse(data['due_date'] as String);
            }
          } catch (_) {}

          // Calendar-month advancement (not +30 days)
          final nextDueDate = DateTime(
            currentDueDate.year,
            currentDueDate.month + 1,
            currentDueDate.day,
          );

          // If remaining is less than monthly EMI, set amount to remaining (for non-rent)
          final nextMonthlyAmount =
              (!isRent && newTotalAmount < emiMonthlyAmount)
              ? newTotalAmount
              : emiMonthlyAmount;

          transaction.update(docRef, {
            'total_amount': isRent ? 999999.0 : newTotalAmount,
            'amount': nextMonthlyAmount,
            'emi_monthly_amount':
                emiMonthlyAmount, // Preserve original monthly amount
            'due_date': nextDueDate.toIso8601String(),
            'last_payment_date': DateTime.now().toIso8601String(),
            'last_payment_amount': amountPaid,
            'status': 'pending',
            'monthly_payments': monthlyPayments,
          });
        }

        // Create detailed payment record in subcollection
        final recordRef = docRef.collection('payment_records').doc();
        final paymentData = {
          'id': recordRef.id,
          'installment_id': installmentId,
          'amount': amountPaid,
          'date': DateTime.now().toIso8601String(),
          'payment_method': paymentMethod,
          'transaction_ref': transactionRef,
          'recorded_by': recordedBy,
          'notes': notes,
          'remaining_balance_after': isRent ? 999999.0 : newTotalAmount,
          'installment_number': installmentNumber,
        };
        transaction.set(recordRef, paymentData);
        
        // Also write to top-level `payments` collection for fast dashboard querying (daily/monthly/yearly aggregations)
        final topPaymentRef = firestore.collection('payments').doc(recordRef.id);
        transaction.set(topPaymentRef, paymentData);

        // Update the customer's service record
        final serviceId = data['service_id'] as String?;
        final customerId = data['customer_id'] as String?;
        final customerName = data['customer_name'] as String?;

        String? resolvedCustomerId = customerId;
        if ((resolvedCustomerId == null || resolvedCustomerId.isEmpty) &&
            customerName != null) {
          // Fallback: lookup by name (for legacy data without customer_id)
          final custSnap = await firestore
              .collection('Customer')
              .where('name', isEqualTo: customerName)
              .limit(1)
              .get();
          if (custSnap.docs.isNotEmpty) {
            resolvedCustomerId = custSnap.docs.first.id;
            // Backfill customer_id for future lookups
            transaction.update(docRef, {'customer_id': resolvedCustomerId});
          }
        }

        if (serviceId != null &&
            resolvedCustomerId != null &&
            resolvedCustomerId.isNotEmpty) {
          final serviceRef = firestore
              .collection('Customer')
              .doc(resolvedCustomerId)
              .collection('services')
              .doc(serviceId);
          transaction.update(serviceRef, {
            'amountPaid': FieldValue.increment(amountPaid),
            'amountPending': FieldValue.increment(-amountPaid),
          });
        }
      });
    } catch (e) {
      throw Exception('Failed to add payment: $e');
    }
  }

  @override
  Future<List<PaymentRecord>> getPaymentHistory() async {
    try {
      if (_firestore == null && Firebase.apps.isEmpty) {
        return [];
      }

      final snapshot = await firestore.collectionGroup('payment_records').get();
      List<PaymentRecord> history = [];

      // We need to resolve names/invoices. Since payment_records are subcollections of installments,
      // we ideally have the customer name inside the record. But currently, the new records don't have it explicitly.
      // Wait, in addPayment, I didn't add customerName to the record. I should fetch parent info if needed,
      // or rely on a Map. Let's do a join with installments or Customer collection if needed.
      // For now, let's just construct the record. If some data is missing, we'll leave it empty.
      // Ideally, the payment_record should have all the denormalized data.
      
      // Let's fetch all installments first for lookup, since it's faster than 1-by-1 reads.
      final installmentsSnap = await firestore.collection('installments').get();
      final installmentDataMap = {
        for (var doc in installmentsSnap.docs) doc.id: doc.data()
      };

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final instId = data['installment_id'] as String? ?? '';
        final instData = installmentDataMap[instId];
        
        final customerName = instData?['customer_name'] as String? ?? 'Unknown';
        final customerId = instData?['customer_id'] as String? ?? '';
        final serviceName = instData?['service_name'] as String? ?? '';
        
        history.add(PaymentRecord(
          id: data['id'] as String? ?? doc.id,
          installmentId: instId,
          customerId: customerId,
          customerName: customerName,
          serviceName: serviceName,
          invoiceNumber: instId,
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          dateStr: data['date'] as String? ?? '',
          paymentMethod: data['payment_method'] as String? ?? 'Cash',
          transactionRef: data['transaction_ref'] as String? ?? '',
          recordedBy: data['recorded_by'] as String? ?? '',
          notes: data['notes'] as String? ?? '',
          remainingBalanceAfter: (data['remaining_balance_after'] as num?)?.toDouble() ?? 0.0,
          installmentNumber: data['installment_number'] as int? ?? 0,
        ));
      }

      // Sort reverse chronological
      history.sort((a, b) {
        final dateA = DateTime.tryParse(a.dateStr) ?? DateTime.fromMillisecondsSinceEpoch(0);
        final dateB = DateTime.tryParse(b.dateStr) ?? DateTime.fromMillisecondsSinceEpoch(0);
        return dateB.compareTo(dateA);
      });

      return history;
    } catch (e) {
      // Return empty instead of crashing
      return [];
    }
  }

  EmiDashboardData _getInitialMockData() {
    return const EmiDashboardData(
      totalOutstandingBalance: 0,
      expectedMonthlyDemand: 0,
      collectedThisMonth: 0,
      overdueClientsCount: 0,
      pendingClientsCount: 0,
      paidThisMonthCount: 0,
      recentlyPaidInstallments: [],
      activeInstallments: [],
    );
  }
}
