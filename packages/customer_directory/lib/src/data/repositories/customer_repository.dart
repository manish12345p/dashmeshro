import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository_interface.dart';

class CustomerRepository implements ICustomerRepository {
  final FirebaseFirestore? _firestore;

  CustomerRepository({FirebaseFirestore? firestore}) : _firestore = firestore;

  FirebaseFirestore get firestore => _firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Customer>> getCustomers() {
    final collectionRef = firestore.collection('Customer');
    return collectionRef.where('isDeleted', isEqualTo: false).snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return <Customer>[];
      }
      
      return snapshot.docs.map((doc) {
        return Customer.fromMap(doc.data(), documentId: doc.id);
      }).toList();
    }).handleError((error) {
      print('Firestore error in getCustomers: $error');
      return <Customer>[];
    });
  }

  @override
  Stream<Customer> getCustomerById(String id) {
    final docRef = firestore.collection('Customer').doc(id);
    return docRef.snapshots().asyncMap((snapshot) async {
      if (!snapshot.exists) {
        throw Exception('Customer not found');
      }
      final data = snapshot.data()!;
      // Fetch services subcollection
      final servicesSnapshot = await docRef.collection('services').orderBy('serviceDate', descending: true).get();
      final servicesList = servicesSnapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
      data['serviceHistory'] = servicesList;
      
      return Customer.fromMap(data, documentId: snapshot.id);
    }).handleError((error) {
      print('Firestore error in getCustomerById: $error');
      throw Exception('Failed to load customer');
    });
  }

  @override
  Future<String> createCustomer(Customer customer) async {
    final collectionRef = firestore.collection('Customer');
    final docId = customer.id.isEmpty ? collectionRef.doc().id : customer.id;
    await collectionRef.doc(docId).set(customer.toMap()..['id'] = docId);
    return docId;
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    final collectionRef = firestore.collection('Customer');
    await collectionRef.doc(customer.id).update(customer.toMap());
  }

  @override
  Future<void> deleteCustomer(String id) async {
    final collectionRef = firestore.collection('Customer');
    await collectionRef.doc(id).update({
      'isDeleted': true,
      'deletedAt': DateTime.now().toIso8601String(),
    });
  }

}
