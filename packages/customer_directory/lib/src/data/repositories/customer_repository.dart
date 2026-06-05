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
    return collectionRef
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) {
            return <Customer>[];
          }

          return snapshot.docs.map((doc) {
            return Customer.fromMap(doc.data(), documentId: doc.id);
          }).toList();
        })
        .handleError((error) {
          print('Firestore error in getCustomers: $error');
          return <Customer>[];
        });
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
          data['serviceHistory'] = servicesList;

          return Customer.fromMap(data, documentId: snapshot.id);
        })
        .handleError((error) {
          print('Firestore error in getCustomerById: $error');
          throw Exception('Failed to load customer');
        });
  }

  @override
  Future<String> createCustomer(Customer customer) async {
    final collectionRef = firestore.collection('Customer');
    final docId = customer.id.isEmpty ? collectionRef.doc().id : customer.id;
    await collectionRef.doc(docId).set(customer.toMap()..['id'] = docId);

    // Create Rent installment automatically if they are a Rent Customer
    if (customer.isRentCustomer) {
      try {
        final emiCollection = firestore.collection('installments');
        final emiId = 'emi_rent_$docId';

        final now = DateTime.now();
        // Rent due date is usually the upcoming month's given day
        final initialDueDate = DateTime(
          now.year,
          now.month,
          customer.rentDueDay,
        );

        final address = customer.address;
        final phone = customer.number;
        final contactInfo = [
          if (address.isNotEmpty) address,
          if (phone.isNotEmpty) phone,
        ].join(' | ');

        await emiCollection.doc(emiId).set({
          'id': emiId,
          'customer_name': customer.name,
          'customer_id': docId,
          'vehicle_details': contactInfo,
          'service_name': 'Monthly Rent',
          'amount': 999999.0, // High constant since Rent never ends
          'emi_monthly_amount': customer.rentAmount,
          'total_amount': 999999.0,
          'original_loan_amount': 999999.0,
          'status': 'pending',
          'due_date': initialDueDate.toIso8601String(),
          'created_at': now.toIso8601String(),
          'is_rent': true,
          'rent_due_day': customer.rentDueDay,
        });
      } catch (e) {
        print('Error creating Rent Installment for Customer: $e');
      }
    }

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
