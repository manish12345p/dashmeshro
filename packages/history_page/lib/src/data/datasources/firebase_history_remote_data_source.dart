import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/entities/history_item.dart';
import 'history_remote_data_source.dart';

class FirebaseHistoryRemoteDataSource implements IHistoryRemoteDataSource {
  final FirebaseFirestore _firestore;

  FirebaseHistoryRemoteDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<HistoryItem>> getAllServices() {
    final customersStream = _firestore.collection('Customer').snapshots();
    final servicesStream = _firestore.collectionGroup('services').snapshots();

    return Rx.combineLatest2(
      customersStream,
      servicesStream,
      (QuerySnapshot customersSnap, QuerySnapshot servicesSnap) {
        final items = <HistoryItem>[];

        // Build a cache of customer data to avoid repeated reads
        final customerCache = <String, Map<String, dynamic>>{};
        for (final doc in customersSnap.docs) {
          customerCache[doc.id] = doc.data() as Map<String, dynamic>;
        }

        for (final doc in servicesSnap.docs) {
          try {
            final data = doc.data() as Map<String, dynamic>;

            // Skip deleted services
            final isDeleted = data['isDeleted'] as bool? ?? false;
            if (isDeleted) continue;

            // Get customerId from the parent reference
            final customerId = doc.reference.parent.parent?.id ?? '';
            if (customerId.isEmpty) continue;

            // Parse serviceDate
            final dateStr =
                data['serviceDate'] as String? ??
                data['service_date'] as String? ??
                '';
            DateTime? serviceDate;
            if (dateStr.isNotEmpty) {
              serviceDate = DateTime.tryParse(dateStr);
            }
            if (serviceDate == null) continue;

            // Get customer name/address — try denormalized fields first, then cache
            String customerName = data['customer_name'] as String? ?? '';
            String customerPhone = data['customer_phone'] as String? ?? '';
            String customerAddress = '';

            final custData = customerCache[customerId];
            
            // Skip orphaned ghost services if the customer no longer exists
            if (custData == null) continue;

            if (customerName.isEmpty) {
              customerName = custData['name'] as String? ?? 'Unknown';
            }
            if (customerPhone.isEmpty) {
              customerPhone = custData['number'] as String? ?? '';
            }
            customerAddress = custData['address'] as String? ?? '';

            final serviceType =
                data['serviceType'] as String? ??
                data['service_type'] as String? ??
                '';
            final fault = data['fixes'] as String? ?? '';
            final remarks = data['remarks'] as String? ?? '';
            final status = data['status'] as String? ?? 'pending';
            final serviceDuration = data['serviceDuration'] as String? ?? '';
            final guaranteeDuration = data['guaranteeDuration'] as String? ?? '';
            final totalAmount =
                (data['totalAmount'] as num?)?.toDouble() ?? 0.0;
            final amountPaid =
                (data['amountPaid'] as num?)?.toDouble() ?? 0.0;
            final amountPending =
                (data['amountPending'] as num?)?.toDouble() ?? 0.0;
            final isComplaint = data['isComplaint'] as bool? ?? false;

            items.add(HistoryItem(
              id: doc.id,
              customerId: customerId,
              customerName: customerName,
              customerAddress: customerAddress,
              customerPhone: customerPhone,
              serviceType: serviceType,
              serviceDate: serviceDate,
              note: remarks,
              fault: fault,
              status: status,
              serviceDuration: serviceDuration,
              guaranteeDuration: guaranteeDuration,
              totalAmount: totalAmount,
              amountPaid: amountPaid,
              amountPending: amountPending,
              isComplaint: isComplaint,
            ));
          } catch (e) {
            debugPrint('Error parsing service doc ${doc.id}: $e');
          }
        }

        // Sort by serviceDate descending (newest first)
        items.sort((a, b) => b.serviceDate.compareTo(a.serviceDate));

        return items;
      },
    ).handleError((error) {
      debugPrint('Firestore error in getAllServices: $error');
      return <HistoryItem>[];
    });
  }
}
