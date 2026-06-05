import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/visit_record.dart';
import '../../domain/repositories/visit_repository_interface.dart';

class VisitEntryRepository implements IVisitEntryRepository {
  final FirebaseFirestore _firestore;

  VisitEntryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createVisitEntry(VisitRecord entry, {double? emiAmountPerMonth}) async {
    final collectionRef = _firestore
        .collection('Customer')
        .doc(entry.customerId)
        .collection('services');
    final docId = entry.id.isEmpty ? collectionRef.doc().id : entry.id;

    // Add notificationDate (2 months after service date) directly to the service doc
    final notificationDate = DateTime(
      entry.serviceDate.year,
      entry.serviceDate.month + 2,
      entry.serviceDate.day,
    );
    final data = entry.toMap()
      ..['id'] = docId
      ..['notificationDate'] = notificationDate.toIso8601String();

    await collectionRef.doc(docId).set(data);

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

    // Auto-create EMI if pending amount exists
    if (entry.amountPending > 0) {
      try {
        final customerSnap = await _firestore.collection('Customer').doc(entry.customerId).get();
        if (customerSnap.exists) {
          final custData = customerSnap.data()!;
          final name = custData['name'] ?? 'Unknown';
          final address = custData['address'] ?? '';
          final phone = custData['number'] ?? '';
          
          final contactInfo = [
            if (address.toString().isNotEmpty) address,
            if (phone.toString().isNotEmpty) phone
          ].join(' | ');

          final emiCollection = _firestore.collection('installments');
          final emiId = 'emi_$docId';
          
          double monthlyAmount = entry.amountPending;
          if (emiAmountPerMonth != null && emiAmountPerMonth > 0 && emiAmountPerMonth < entry.amountPending) {
            monthlyAmount = emiAmountPerMonth;
          }

          // Calendar-month advancement for initial due date (not +30 days)
          final now = DateTime.now();
          final initialDueDate = DateTime(now.year, now.month + 1, now.day);

          // Create a meaningful service identifier
          final String svcName = [
            if (entry.serviceType.isNotEmpty) entry.serviceType,
            if (entry.roType != null && entry.roType!.isNotEmpty) '(${entry.roType})'
          ].join(' ');

          await emiCollection.doc(emiId).set({
            'id': emiId,
            'customer_name': name,
            'customer_id': entry.customerId,
            'vehicle_details': contactInfo,
            'service_name': svcName.isEmpty ? 'Service #${docId.substring(0, 5)}' : svcName,
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
        // Log but don't fail the service entry creation
        throw Exception('Service saved but EMI creation failed: $e');
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
      final snapshot = await _firestore.collection('Customer').limit(100).get();
      
      final results = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).where((data) {
        final name = (data['name'] as String?)?.toLowerCase() ?? '';
        final phone = (data['number'] as String?)?.toLowerCase() ?? '';
        return name.contains(queryLower) || phone.contains(queryLower);
      }).take(10).toList();

      return results;
    } catch (_) {
      return [];
    }
  }
}
