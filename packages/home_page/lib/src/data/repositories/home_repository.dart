import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/repositories/home_repository_interface.dart';

class HomeRepository implements IHomeRepository {
  final FirebaseFirestore? _firestore;

  HomeRepository({FirebaseFirestore? firestore}) : _firestore = firestore;

  FirebaseFirestore get firestore => _firestore ?? FirebaseFirestore.instance;

  @override
  Stream<HomeData> getHomeData() {
    // If Firebase is not initialized (e.g., in widget tests), return the mock data stream.
    if (_firestore == null && Firebase.apps.isEmpty) {
      return Stream.value(_getInitialMockData());
    }

    final docRef = firestore.collection('home_data').doc('dashboard');
    return docRef.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        final initialData = _getInitialMockData();
        // Seed the database with the initial mock data asynchronously
        docRef.set(initialData.toMap());
        return initialData;
      }
      final data = snapshot.data() ?? {};
      return HomeData.fromMap(data);
    });
  }

  HomeData _getInitialMockData() {
    return const HomeData(
      newSells: 14,
      activeRentals: 32,
      activeAmcs: 128,
      resolutionRatePercent: 94,
      pendingComplaintsCount: 6,
      todaySchedules: [
        ScheduleItem(
          title: 'Leakage Issue - Terminal 4',
          subtitle: 'Assigned to: Senior Mech Team',
          time: '09:30 AM',
          isUrgent: true,
        ),
        ScheduleItem(
          title: 'Power Failure - Unit B2',
          subtitle: 'Assigned to: Rapid Response',
          time: '11:15 AM',
          isUrgent: true,
        ),
        ScheduleItem(
          title: 'Quarterly Check - Skyline Plaza',
          subtitle: 'Customer ID: S2MC-882',
          time: '02:00 PM',
          isUrgent: false,
        ),
      ],
      pendingComplaints: [
        ComplaintItem(
          customerName: 'Apex Manufacturing',
          customerId: 'MCP-001',
          issueType: 'Low Flow Rate',
          status: 'urgent',
        ),
        ComplaintItem(
          customerName: 'Global Logistics Co.',
          customerId: 'MCP-0042',
          issueType: 'Seal Leakage',
          status: 'high',
        ),
        ComplaintItem(
          customerName: 'Heritage Estates',
          customerId: 'MCP-0021',
          issueType: 'System Shutdown',
          status: 'urgent',
        ),
      ],
      amcProgresses: [
        AmcProgress(
          companyName: 'Industrial Hub Corp',
          progress: 0.85,
          statusText: 'Almost to onboarding + With services done',
          isUrgent: false,
        ),
        AmcProgress(
          companyName: 'Central Park Estates',
          progress: 0.25,
          statusText: '2 mos for checkup + Urgent renewal',
          isUrgent: true,
        ),
      ],
      todaySellsSummary: 4,
      weekSellsSummary: 14,
      projectedGrowth: '+12% vs LW',
    );
  }

  @override
  Future<void> createHomeData(HomeData data) async {
    if (_firestore == null && Firebase.apps.isEmpty) return;
    await firestore
        .collection('home_data')
        .doc('dashboard')
        .set(data.toMap());
  }

  @override
  Future<void> updateHomeData(HomeData data) async {
    if (_firestore == null && Firebase.apps.isEmpty) return;
    await firestore
        .collection('home_data')
        .doc('dashboard')
        .set(data.toMap(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteHomeData(String id) async {
    if (_firestore == null && Firebase.apps.isEmpty) return;
    await firestore
        .collection('home_data')
        .doc(id)
        .delete();
  }
}
