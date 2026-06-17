import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository_interface.dart';

import 'package:rxdart/rxdart.dart';

class CustomerRepository implements ICustomerRepository {
  final FirebaseFirestore? _firestore;
  Stream<List<Customer>>? _cachedCustomersStream;

  CustomerRepository({FirebaseFirestore? firestore}) : _firestore = firestore;

  FirebaseFirestore get firestore => _firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Customer>> getCustomers() {
    if (_cachedCustomersStream != null) return _cachedCustomersStream!;

    final collectionRef = firestore.collection('Customer');
    _cachedCustomersStream = collectionRef
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) {
            return <Customer>[];
          }

          final docsData = snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
          return _parseCustomersTask(docsData);
        })
        .handleError((error) {
          debugPrint('Firestore error in getCustomers: $error');
          return <Customer>[];
        })
        .shareReplay(maxSize: 1);

    return _cachedCustomersStream!;
  }

  @override
  Stream<Customer> getCustomerById(String id) {
    final docRef = firestore.collection('Customer').doc(id);
    return docRef
        .snapshots()
        .asyncMap((snapshot) async {
          if (!snapshot.exists) {
            throw Exception('Customer not found');
          }
          final data = snapshot.data()!;
          // Fetch services subcollection
          final servicesSnapshot = await docRef
              .collection('services')
              .orderBy('serviceDate', descending: true)
              .get();
          final servicesList = servicesSnapshot.docs
              .map((doc) => doc.data()..['id'] = doc.id)
              .toList();
          data['service_history'] = servicesList;

          return Customer.fromJson(data..['id'] = snapshot.id);
        })
        .handleError((error) {
          debugPrint('Firestore error in getCustomerById: $error');
          throw Exception('Failed to load customer');
        });
  }

  @override
  Future<String> createCustomer(Customer customer) async {
    final collectionRef = firestore.collection('Customer');
    final docId = customer.id.isEmpty ? collectionRef.doc().id : customer.id;
    await collectionRef.doc(docId).set(
      customer.toJson()
        ..['id'] = docId
        ..['created_at'] = DateTime.now().toIso8601String(),
    );

    return docId;
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    final collectionRef = firestore.collection('Customer');
    await collectionRef.doc(customer.id).update(customer.toJson());
  }

  @override
  Future<void> deleteCustomer(String id) async {
    final customerRef = firestore.collection('Customer').doc(id);

    // 1. Delete all services in the subcollection
    final servicesSnap = await customerRef.collection('services').get();
    for (var doc in servicesSnap.docs) {
      await doc.reference.delete();
    }

    // 2. Delete all payments for this customer
    final paymentsSnap = await firestore
        .collection('payments')
        .where('customer_id', isEqualTo: id)
        .get();
    for (var doc in paymentsSnap.docs) {
      await doc.reference.delete();
    }

    // 3. Delete all installments for this customer
    final installmentsSnap = await firestore
        .collection('installments')
        .where('customerId', isEqualTo: id)
        .get();
    for (var doc in installmentsSnap.docs) {
      await doc.reference.delete();
    }

    // 4. Finally delete the customer document itself
    await customerRef.delete();
  }

  @override
  Future<bool> checkCustomerExistsByPhone(String phone) async {
    final collectionRef = firestore.collection('Customer');
    final query = await collectionRef
        .where('number', isEqualTo: phone)
        .limit(1)
        .get();
    return query.docs.isNotEmpty;
  }
}

List<Customer> _parseCustomersTask(List<Map<String, dynamic>> rawDataList) {
  final filtered = rawDataList.toList();
  
  filtered.sort((a, b) {
    final t1 = a['created_at'] as String?;
    final t2 = b['created_at'] as String?;
    if (t1 == null && t2 == null) return 0;
    if (t1 == null) return 1;
    if (t2 == null) return -1;
    return t2.compareTo(t1);
  });

  return filtered.map((data) => Customer.fromJson(data)).toList();
}
