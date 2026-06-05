import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentTracker {
  static Future<void> recordPayment(String customerId, double amount, String source, String referenceId) async {
    if (amount <= 0) return;
    try {
      await FirebaseFirestore.instance.collection('payments').add({
        'customer_id': customerId,
        'amount': amount,
        'source': source,
        'reference_id': referenceId,
        'date': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Failed to record payment: $e');
    }
  }
}
