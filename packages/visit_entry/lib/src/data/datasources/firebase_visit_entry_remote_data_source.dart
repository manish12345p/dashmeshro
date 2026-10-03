import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/visit_record.dart';
import 'visit_entry_remote_data_source.dart';

class FirebaseVisitEntryRemoteDataSource implements IVisitEntryRemoteDataSource {
  final FirebaseFirestore _firestore;

  FirebaseVisitEntryRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createVisitEntry(
    VisitRecord entry, {
    double? emiAmountPerMonth,
    int? totalAmcVisitsToPurchase,
  }) async {
    final collectionRef = _firestore
        .collection('Customer')
        .doc(entry.customerId)
        .collection('services');
    final docId = entry.id.isEmpty ? collectionRef.doc().id : entry.id;

    // Fetch customer data to store name and phone directly in the service document
    final customerSnap = await _firestore.collection('Customer').doc(entry.customerId).get();
    String? customerName;
    String? customerPhone;
    if (customerSnap.exists) {
       final cData = customerSnap.data()!;
       customerName = cData['name'];
       customerPhone = cData['number'];
    }

    final data = entry.toJson()
      ..['id'] = docId;
      
    if (customerName != null) data['customer_name'] = customerName;
    if (customerPhone != null) data['customer_phone'] = customerPhone;

    await collectionRef.doc(docId).set(data);

    // AMC tracking logic
    if (entry.serviceType.toLowerCase().contains('amc')) {
      final custDocRef = _firestore.collection('Customer').doc(entry.customerId);
      await _firestore.runTransaction((transaction) async {
        final snap = await transaction.get(custDocRef);
        if (snap.exists) {
          final customerData = snap.data()!;
          int remaining = customerData['remainingAmcVisits'] ?? customerData['remaining_amc_visits'] ?? 0;
          if (remaining > 0) {
            transaction.update(custDocRef, {
              'remainingAmcVisits': remaining - 1,
              'remaining_amc_visits': remaining - 1,
            });
          } else if (totalAmcVisitsToPurchase != null && totalAmcVisitsToPurchase > 0) {
            transaction.update(custDocRef, {
              'totalAmcVisits': totalAmcVisitsToPurchase,
              'total_amc_visits': totalAmcVisitsToPurchase,
              'remainingAmcVisits': totalAmcVisitsToPurchase - 1,
              'remaining_amc_visits': totalAmcVisitsToPurchase - 1,
            });
          }
        }
      });
    }

    // Record payment if amountPaid > 0
    if (entry.amountPaid > 0) {
      try {
        await _firestore.collection('payments').add({
          'customer_id': entry.customerId,
          'amount': entry.amountPaid,
          'source': 'visit_entry',
          'reference_id': docId,
          'date': DateTime.now().toIso8601String(),
        });
      } catch (e) {
        // ignore
      }
    }

    // Create EMI installment if needed
    if (entry.amountPending > 0) {
      try {
        final customerSnap = await _firestore
            .collection('Customer')
            .doc(entry.customerId)
            .get();
        if (customerSnap.exists) {
          final custData = customerSnap.data()!;
          final name = custData['name'] ?? 'Unknown';
          final address = custData['address'] ?? '';
          final phone = custData['number'] ?? '';

          final contactInfo = [
            if (address.toString().isNotEmpty) address,
            if (phone.toString().isNotEmpty) phone,
          ].join(' | ');

          final emiCollection = _firestore.collection('installments');
          final emiId = 'emi_$docId';

          double monthlyAmount = entry.amountPending;
          if (emiAmountPerMonth != null &&
              emiAmountPerMonth > 0 &&
              emiAmountPerMonth < entry.amountPending) {
            monthlyAmount = emiAmountPerMonth;
          }

          // Calendar-month advancement for initial due date (not +30 days)
          final now = DateTime.now();
          DateTime initialDueDate = DateTime(now.year, now.month + 1, now.day);

          // Create a meaningful service identifier
          final String svcName = [
            if (entry.serviceType.isNotEmpty) entry.serviceType,
            if (entry.roType != null && entry.roType!.isNotEmpty)
              '(${entry.roType})',
          ].join(' ');

          await emiCollection.doc(emiId).set({
            'id': emiId,
            'customer_name': name,
            'customer_id': entry.customerId,
            'vehicle_details': contactInfo,
            'service_name': svcName.isEmpty
                ? 'Service #${docId.substring(0, 5)}'
                : svcName,
            'amount': monthlyAmount,
            'emi_monthly_amount': monthlyAmount,
            'total_amount': entry.amountPending,
            'original_loan_amount': entry.amountPending,
            'status': 'pending',
            'due_date': initialDueDate.toIso8601String(),
            'created_at': now.toIso8601String(),
            'service_id': docId,
          });
        }
      } catch (e) {
        throw Exception('Service saved but EMI/Rent creation failed: $e');
      }
    }
  }

  @override
  Future<List<String>> getRoTypes() async {
    try {
      final snapshot = await _firestore.collection('RoType').limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        for (final value in data.values) {
          if (value is Iterable) {
            return List<String>.from(value);
          }
        }
      }
    } catch (_) {
      // Ignore and return defaults
    }
    return ['Commercial', 'Domestic', 'Industrial'];
  }

  @override
  Future<List<Map<String, dynamic>>> searchCustomers(String query) async {
    try {
      if (query.isEmpty) return [];

      final queryLower = query.toLowerCase();
      
      QuerySnapshot<Map<String, dynamic>> snapshot;
      try {
        // Try getting from local cache first
        snapshot = await _firestore.collection('Customer').get(
          const GetOptions(source: Source.cache),
        );
        if (snapshot.docs.isEmpty) {
          snapshot = await _firestore.collection('Customer').get();
        }
      } catch (_) {
        snapshot = await _firestore.collection('Customer').get();
      }

      final results = snapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return data;
          })
          .where((data) {
            bool matches = false;
            for (var entry in data.entries) {
              final key = entry.key.toLowerCase();
              final val = entry.value;

              if (val == null) continue;

              // Skip amounts and dates/times
              if (key.contains('date') ||
                  key.contains('amount') ||
                  key.contains('time') ||
                  key.contains('health') ||
                  key.contains('visit') ||
                  key.contains('deletedat')) {
                continue;
              }

              if (val.toString().toLowerCase().contains(queryLower)) {
                matches = true;
                break;
              }
            }
            return matches;
          })
          .take(10)
          .toList();

      return results;
    } catch (_) {
      return [];
    }
  }
}
