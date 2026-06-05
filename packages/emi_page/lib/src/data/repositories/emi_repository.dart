import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/emi_dashboard_data.dart';
import '../../domain/repositories/emi_repository_interface.dart';

class EmiRepository implements EmiRepositoryInterface {
  final FirebaseFirestore? _firestore;

  EmiRepository({FirebaseFirestore? firestore}) : _firestore = firestore;

  FirebaseFirestore get firestore => _firestore ?? FirebaseFirestore.instance;

  @override
  Future<EmiDashboardData> getEmiDashboardData() async {
    if (_firestore == null && Firebase.apps.isEmpty) {
      return _getInitialMockData();
    }

    try {
      final snapshotMonthYear = '${DateTime.now().year}_${DateTime.now().month.toString().padLeft(2, '0')}';
      final snapshotDoc = firestore.collection('emi_monthly_snapshots').doc(snapshotMonthYear);
      final snapshotData = await snapshotDoc.get();

      double totalExpectedThisMonth = 0;
      bool saveNewSnapshot = false;
      if (snapshotData.exists) {
        totalExpectedThisMonth = (snapshotData.data()!['totalExpected'] as num?)?.toDouble() ?? 0.0;
      } else {
        saveNewSnapshot = true;
      }

      final snapshot = await firestore.collection('installments').get();

      double collectedThisMonth = 0;
      double lifetimeCollection = 0;
      List<RecentlyPaidInstallment> recentlyPaidInstallments = [];
      List<ActiveInstallment> activeInstallments = [];
      int earlyPayments = 0;
      int defaulters = 0;
      int pendingClientsCount = 0;
      Set<String> customersPaidThisMonth = {};
      int totalActiveCount = 0;
      double actualPendingThisMonth = 0.0;
      int actualPendingClientsCount = 0;

      final today = DateTime.now();
      final currentMonth = today.month;
      final currentYear = today.year;

      // Fetch customers to map name -> id
      final customerSnap = await firestore.collection('Customer').get();
      final Map<String, String> nameToIdMap = {};
      for (var c in customerSnap.docs) {
        final name = c.data()['name'] as String? ?? '';
        if (name.isNotEmpty) {
          nameToIdMap[name] = c.id;
        }
      }

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final emiMonthlyAmount = (data['emi_monthly_amount'] as num?)?.toDouble() 
            ?? (data['amount'] as num?)?.toDouble() 
            ?? 0.0;
        final status = data['status'] as String? ?? 'pending';
        final amount = (status == 'paid') ? emiMonthlyAmount : ((data['amount'] as num?)?.toDouble() ?? 0.0);
        final dueDateStr = data['due_date'] as String? ?? '';
        final customerName = data['customer_name'] as String? ?? 'Unknown';
        final customerId = data['customer_id'] as String? ?? nameToIdMap[customerName] ?? '';
        final vehicleDetails = data['vehicle_details'] as String? ?? '';
        // Use snake_case consistently for Firestore field names
        final totalAmount = (data['total_amount'] as num?)?.toDouble() 
            ?? (data['totalAmount'] as num?)?.toDouble() 
            ?? 0.0;
        final lastPaymentDateStr = data['last_payment_date'] as String? ?? data['paid_at'] as String? ?? '';
        final lastPaymentAmount = (data['last_payment_amount'] as num?)?.toDouble() ?? 0.0;

        // Skip completely empty/invalid records (but do NOT delete them)
        if (amount <= 0 && totalAmount <= 0 && status != 'paid') continue;

        DateTime? dueDate;
        try {
          if (dueDateStr.isNotEmpty) dueDate = DateTime.parse(dueDateStr);
        } catch (_) {}

        DateTime? lastPaymentDate;
        try {
          if (lastPaymentDateStr.isNotEmpty) lastPaymentDate = DateTime.parse(lastPaymentDateStr);
        } catch (_) {}

        // Determine effective status
        final bool paidThisMonth = lastPaymentDate != null 
            && lastPaymentDate.month == currentMonth 
            && lastPaymentDate.year == currentYear;

        String effectiveStatus;
        if (status == 'paid') {
          // Fully paid off (total_amount == 0)
          effectiveStatus = 'paid';
        } else if (status == 'overdue') {
          // It was explicitly marked as overdue in the database
          effectiveStatus = 'overdue';
        } else if (dueDate != null && dueDate.isBefore(DateTime(today.year, today.month, today.day))) {
          // Due date is in the past -> Overdue! (Even if they made a payment this month, if they are still behind, they are overdue)
          effectiveStatus = 'overdue';
        } else if (paidThisMonth && status == 'pending') {
          // Due date is in the future, AND they made a payment this month
          effectiveStatus = 'paid_this_month';
        } else {
          effectiveStatus = 'pending';
        }

        double originalLoanAmount = (data['original_loan_amount'] as num?)?.toDouble() ?? 0.0;
        String serviceName = data['service_name'] as String? ?? '';
        final serviceId = data['service_id'] as String?;

        if (originalLoanAmount == 0.0 || serviceName.isEmpty) {
          if (serviceId != null && customerId.isNotEmpty) {
            final svcDoc = await firestore.collection('Customer').doc(customerId).collection('services').doc(serviceId).get();
            if (svcDoc.exists) {
              final svcData = svcDoc.data()!;
              if (originalLoanAmount == 0.0) {
                 originalLoanAmount = (svcData['amountPending'] as num?)?.toDouble() ?? totalAmount;
              }
              if (serviceName.isEmpty) {
                 final st = svcData['serviceType'] as String? ?? '';
                 final rt = svcData['roType'] as String? ?? '';
                 serviceName = [st, if (rt.isNotEmpty) '($rt)'].join(' ').trim();
                 if (serviceName.isEmpty) serviceName = 'Service #${serviceId.substring(0, 5)}';
              }
              // Backfill the data asynchronously
              doc.reference.update({
                if ((data['original_loan_amount'] as num?)?.toDouble() != originalLoanAmount) 'original_loan_amount': originalLoanAmount,
                if ((data['service_name'] as String?) != serviceName) 'service_name': serviceName,
              }).catchError((_) {});
            }
          }
          if (originalLoanAmount == 0.0) originalLoanAmount = totalAmount; // Fallback
        }

        // --- Dashboard aggregation ---

        // Total expected this month snapshot logic
        if (saveNewSnapshot && status != 'paid') {
          if (dueDate != null && dueDate.month == currentMonth && dueDate.year == currentYear) {
            totalExpectedThisMonth += emiMonthlyAmount;
          }
        }
        
        if (effectiveStatus == 'pending' && dueDate != null && dueDate.month == currentMonth && dueDate.year == currentYear) {
            actualPendingThisMonth += emiMonthlyAmount;
            actualPendingClientsCount++;
        }

        if (status != 'paid') {
          totalActiveCount++;
        }

        // Collected this month = sum of payments made this month
        final monthKey = '${currentYear}-${currentMonth.toString().padLeft(2, '0')}';
        final monthlyPayments = data['monthly_payments'] as Map<String, dynamic>?;
        if (monthlyPayments != null && monthlyPayments.containsKey(monthKey)) {
          collectedThisMonth += (monthlyPayments[monthKey] as num).toDouble();
          if (customerId.isNotEmpty) customersPaidThisMonth.add(customerId);
        } else if (paidThisMonth) {
          collectedThisMonth += lastPaymentAmount;
          if (customerId.isNotEmpty) customersPaidThisMonth.add(customerId);
        }

        if (paidThisMonth) {
          if (customerId.isNotEmpty) customersPaidThisMonth.add(customerId);

          if (recentlyPaidInstallments.length < 5) {
            final date = lastPaymentDate!;
            final formattedDate = '${date.day}/${date.month}/${date.year}';
            recentlyPaidInstallments.add(RecentlyPaidInstallment(
              id: data['id'] as String? ?? doc.id,
              customerId: customerId,
              customerName: customerName,
              amount: lastPaymentAmount,
              paidDateStr: 'Paid on $formattedDate',
            ));
          }
        }

        // Lifetime collection: sum of all payments ever recorded
        if (lastPaymentAmount > 0) {
          lifetimeCollection += lastPaymentAmount;
        }

        // Count pending/overdue clients (not paid_this_month or fully paid)
        if (effectiveStatus == 'pending' || effectiveStatus == 'overdue') {
          pendingClientsCount++;
          if (effectiveStatus == 'overdue') {
            defaulters++;
          }
        }

        if (effectiveStatus == 'paid_this_month') {
          earlyPayments++; // Reuse as "on-time payments" count
        }

        activeInstallments.add(ActiveInstallment(
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
        ));
      }

      if (saveNewSnapshot) {
        await snapshotDoc.set({'totalExpected': totalExpectedThisMonth});
      }

      // Sort active installments by due date (oldest first for overdue prioritization)
      activeInstallments.sort((a, b) {
        final dateA = DateTime.tryParse(a.dueDate) ?? DateTime.now();
        final dateB = DateTime.tryParse(b.dueDate) ?? DateTime.now();
        return dateA.compareTo(dateB);
      });

      int paidThisMonthCount = customersPaidThisMonth.length;
      final double onTimePercent = totalActiveCount > 0 
          ? (paidThisMonthCount / totalActiveCount) * 100 
          : 100.0;

      final double collectionPercentage = totalExpectedThisMonth > 0 
          ? (collectedThisMonth / totalExpectedThisMonth) * 100 
          : 0.0;

      return EmiDashboardData(
        totalCollection: totalExpectedThisMonth,
        collectedThisMonth: collectedThisMonth,
        lifetimeServiceRevenue: lifetimeCollection,
        collectionGrowthPercentage: collectionPercentage,
        pendingThisMonth: actualPendingThisMonth,
        pendingClientsCount: actualPendingClientsCount,
        monthlyTargetCollectionPercentage: collectionPercentage,
        recentlyPaidInstallments: recentlyPaidInstallments,
        activeInstallments: activeInstallments,
        onTimePaymentPercentage: onTimePercent,
        earlyPayments: earlyPayments,
        gracePeriod: paidThisMonthCount,
        defaulters: defaulters,
      );
    } catch (e) {
      return _getInitialMockData();
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
  Future<void> addPayment(String installmentId, double amountPaid) async {
    try {
      await firestore.runTransaction((transaction) async {
        final docRef = firestore.collection('installments').doc(installmentId);
        final doc = await transaction.get(docRef);
        if (!doc.exists) return;

        final data = doc.data()!;
        // Read total_amount (snake_case) with fallback to totalAmount (camelCase)
        final currentTotalAmount = (data['total_amount'] as num?)?.toDouble() 
            ?? (data['totalAmount'] as num?)?.toDouble() 
            ?? (data['amount'] as num?)?.toDouble() 
            ?? 0.0;
        final emiMonthlyAmount = (data['emi_monthly_amount'] as num?)?.toDouble() 
            ?? (data['amount'] as num?)?.toDouble() 
            ?? currentTotalAmount;

        final newTotalAmount = currentTotalAmount - amountPaid;

        final monthKey = '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';
        final monthlyPayments = data['monthly_payments'] != null 
            ? Map<String, dynamic>.from(data['monthly_payments'] as Map)
            : <String, dynamic>{};
        
        double currentMonthPaid = (monthlyPayments[monthKey] as num?)?.toDouble() ?? 0.0;
        
        if (currentMonthPaid == 0.0) {
            try {
                final lpdStr = data['last_payment_date'] as String? ?? data['paid_at'] as String? ?? '';
                if (lpdStr.isNotEmpty) {
                    final lpd = DateTime.parse(lpdStr);
                    if (lpd.month == DateTime.now().month && lpd.year == DateTime.now().year) {
                        currentMonthPaid = (data['last_payment_amount'] as num?)?.toDouble() ?? 0.0;
                    }
                }
            } catch (_) {}
        }
        
        monthlyPayments[monthKey] = currentMonthPaid + amountPaid;

        if (newTotalAmount <= 0) {
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

          // If remaining is less than monthly EMI, set amount to remaining
          final nextMonthlyAmount = newTotalAmount < emiMonthlyAmount 
              ? newTotalAmount 
              : emiMonthlyAmount;

          transaction.update(docRef, {
            'total_amount': newTotalAmount,
            'amount': nextMonthlyAmount,
            'emi_monthly_amount': emiMonthlyAmount, // Preserve original monthly amount
            'due_date': nextDueDate.toIso8601String(),
            'last_payment_date': DateTime.now().toIso8601String(),
            'last_payment_amount': amountPaid,
            'status': 'pending',
            'monthly_payments': monthlyPayments,
          });
        }

        // Update the customer's service record
        final serviceId = data['service_id'] as String?;
        final customerId = data['customer_id'] as String?;
        final customerName = data['customer_name'] as String?;

        String? resolvedCustomerId = customerId;
        if ((resolvedCustomerId == null || resolvedCustomerId.isEmpty) && customerName != null) {
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

        if (serviceId != null && resolvedCustomerId != null && resolvedCustomerId.isNotEmpty) {
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

  EmiDashboardData _getInitialMockData() {
    return const EmiDashboardData(
      totalCollection: 0,
      collectedThisMonth: 0,
      lifetimeServiceRevenue: 0,
      collectionGrowthPercentage: 0,
      pendingThisMonth: 0,
      pendingClientsCount: 0,
      monthlyTargetCollectionPercentage: 0,
      recentlyPaidInstallments: [],
      activeInstallments: [],
      onTimePaymentPercentage: 100,
      earlyPayments: 0,
      gracePeriod: 0,
      defaulters: 0,
    );
  }
}
