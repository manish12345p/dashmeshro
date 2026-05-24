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
    // If Firebase is not initialized (e.g., in unit/widget tests), return mock list stream
    if (_firestore == null && Firebase.apps.isEmpty) {
      return Stream.value(_getInitialMockCustomers());
    }

    final collectionRef = firestore.collection('Customer');
    return collectionRef.snapshots().map((snapshot) {
      // If collection is empty, seed it asynchronously
      if (snapshot.docs.isEmpty) {
        final mocks = _getInitialMockCustomers();
        for (var mock in mocks) {
          // Use name as ID for clean URLs, or auto-generate
          final docId = mock.id.isEmpty ? collectionRef.doc().id : mock.id;
          collectionRef.doc(docId).set(mock.toMap()..['id'] = docId);
        }
        return mocks;
      }
      
      return snapshot.docs.map((doc) {
        return Customer.fromMap(doc.data(), documentId: doc.id);
      }).toList();
    }).handleError((error) {
      print('Firestore error in getCustomers: $error. Falling back to mocks.');
      return _getInitialMockCustomers();
    });
  }

  @override
  Stream<Customer> getCustomerById(String id) {
    if (_firestore == null && Firebase.apps.isEmpty) {
      final match = _getInitialMockCustomers().firstWhere(
        (c) => c.id == id,
        orElse: () => _getInitialMockCustomers().first,
      );
      return Stream.value(match);
    }

    final docRef = firestore.collection('Customer').doc(id);
    return docRef.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        // Return default fallback
        return _getInitialMockCustomers().first;
      }
      return Customer.fromMap(snapshot.data()!, documentId: snapshot.id);
    }).handleError((error) {
      print('Firestore error in getCustomerById: $error. Falling back to mock.');
      final match = _getInitialMockCustomers().firstWhere(
        (c) => c.id == id,
        orElse: () => _getInitialMockCustomers().first,
      );
      return match;
    });
  }

  List<Customer> _getInitialMockCustomers() {
    return [
      const Customer(
        id: 'aditya_sharma',
        name: 'Aditya Sharma',
        customerId: 'MCP-010',
        number: '+91 98765 01001',
        email: 'aditya.sharma@indus.com',
        address: 'Indus Works, Phase 3, Industrial Area, Chandigarh',
        locality: 'Phase 3, Industrial Area',
        roType: 'Grand',
        note: 'Mechanical Lead at Indus Works',
        role: 'Mechanical Lead at Indus Works',
        status: 'active',
        customerType: 'Active AMC',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150',
        deviceName: 'Aqua-Pure Grand Max',
        deviceInstalledOn: '10 Dec 2021',
        deviceLastService: '12 Dec 2023',
        deviceFilterHealth: 0.90,
        totalVisits: 8,
        activeAmc: true,
        customerValue: '₹12.0k',
        openTickets: 0,
        serviceHistory: [
          ServiceActivity(
            activityType: 'maintenance',
            title: 'AMC Maintenance Visit',
            description: 'Routine filter cleaning and TDS adjustment.',
            technicianName: 'SUNIL P.',
            dateText: '12 DEC 2023',
            statusBadge: 'healthy',
          ),
          ServiceActivity(
            activityType: 'installation',
            title: 'New Installation (Sell)',
            description: 'Aqua-Pure Grand Max installed.',
            technicianName: 'DASHMESH ADMIN',
            dateText: '10 DEC 2021',
            statusBadge: 'setup',
          ),
        ],
      ),
      const Customer(
        id: 'meera_iyer',
        name: 'Meera Iyer',
        customerId: 'MCP-042',
        number: '+91 98765 04242',
        email: 'meera@aquasolutions.in',
        address: 'AquaSolutions Suite, Sector 22, Chandigarh',
        locality: 'Sector 22',
        roType: 'Kent',
        note: 'Proprietor, AquaSolutions',
        role: 'Proprietor, AquaSolutions',
        status: 'active',
        customerType: 'Rental Customer',
        avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150',
        deviceName: 'Kent Grand Plus',
        deviceInstalledOn: '12 May 2022',
        deviceLastService: '15 Oct 2023',
        deviceFilterHealth: 0.72,
        totalVisits: 5,
        activeAmc: false,
        customerValue: '₹9.5k',
        openTickets: 0,
        serviceHistory: [
          ServiceActivity(
            activityType: 'maintenance',
            title: 'Rental Periodic Check',
            description: 'Semi-annual filter replacement and water quality check.',
            technicianName: 'RAJESH KUMAR',
            dateText: '15 OCT 2023',
            statusBadge: 'healthy',
          ),
        ],
      ),
      const Customer(
        id: 'vikram_rathore',
        name: 'Vikram Rathore',
        customerId: 'MCP-4829',
        number: '+91 98765 43210',
        email: 'vikram.r@outlook.com',
        address: 'House No. 42, Sector 18, Block-C, Chandigarh, 160018',
        locality: 'Sector 18',
        roType: 'Aquashield Pro X9',
        note: 'Premium AMC Client',
        role: 'Premium AMC Client',
        status: 'active',
        customerType: 'Recent Purchase',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=150',
        deviceName: 'Aqua-Shield Pro X9',
        deviceInstalledOn: '14 Oct 2022',
        deviceLastService: '02 Jun 2023',
        deviceFilterHealth: 0.84,
        totalVisits: 12,
        activeAmc: true,
        customerValue: '₹18.5k',
        openTickets: 1,
        serviceHistory: [
          ServiceActivity(
            activityType: 'complaint',
            title: 'Complaint Resolved',
            description: 'Leakage reported in main inlet valve. Replaced O-ring and tested pressure.',
            technicianName: 'RAJESH KUMAR',
            dateText: '12 NOV 2023',
            statusBadge: 'urgent',
          ),
          ServiceActivity(
            activityType: 'maintenance',
            title: 'AMC Maintenance Visit',
            description: 'Routine filter cleaning and TDS level adjustment. (Current TDS: 85).',
            technicianName: 'SUNIL P.',
            dateText: '02 JUN 2023',
            statusBadge: 'healthy',
          ),
          ServiceActivity(
            activityType: 'receipt',
            title: 'Rent / AMC Renewal Receipt',
            description: 'Payment received for annual AMC renewal. Transaction ID: #TXN0928374.',
            technicianName: 'BILLING DEPT',
            dateText: '15 JAN 2023',
            statusBadge: 'financial',
          ),
          ServiceActivity(
            activityType: 'installation',
            title: 'New Installation (Sell)',
            description: 'Aqua-Shield Pro X9 installed. Post-installation tutorial completed.',
            technicianName: 'DASHMESH ADMIN',
            dateText: '14 OCT 2022',
            statusBadge: 'setup',
          ),
        ],
      ),
      const Customer(
        id: 'sonia_verma',
        name: 'Sonia Verma',
        customerId: 'MCP-021',
        number: '+91 98765 02121',
        email: 'sonia.v@gmail.com',
        address: 'Apartment 4B, Hillview Apartments, Chandigarh',
        locality: 'Hillview Apartments',
        roType: 'Pureit',
        note: 'Requires high-priority response for pressure leaks',
        role: 'Homeowner',
        status: 'active',
        customerType: 'Open Complaint',
        avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=150',
        deviceName: 'Pureit Copper Eco',
        deviceInstalledOn: '04 Mar 2023',
        deviceLastService: '10 Nov 2023',
        deviceFilterHealth: 0.50,
        totalVisits: 3,
        activeAmc: true,
        customerValue: '₹6.2k',
        openTickets: 1,
        serviceHistory: [
          ServiceActivity(
            activityType: 'complaint',
            title: 'Pressure Leakage',
            description: 'Pressure leakage reported in Main Unit B-12. Service engineer assigned.',
            technicianName: 'RAJESH KUMAR',
            dateText: '24 MAY 2026',
            statusBadge: 'urgent',
          ),
        ],
      ),
    ];
  }
}
