import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:core_ui/core_ui.dart';

class VisitSearchDelegate extends SearchDelegate<String?> {
  // Cache: customerId -> list of service data maps
  Map<String, List<Map<String, dynamic>>>? _servicesCache;

  VisitSearchDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Customer').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (query.isEmpty) {
          // Show all customers when no query
          return _buildCustomerList(context, docs);
        }

        // For search with services, we need FutureBuilder
        return FutureBuilder<List<DocumentSnapshot>>(
          future: _filterWithServices(docs),
          builder: (context, asyncSnap) {
            if (!asyncSnap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildCustomerList(context, asyncSnap.data!);
          },
        );
      },
    );
  }

  Future<List<DocumentSnapshot>> _filterWithServices(
    List<QueryDocumentSnapshot> docs,
  ) async {
    // Build services cache if not exists
    if (_servicesCache == null) {
      _servicesCache = {};
      for (var doc in docs) {
        final servicesSnap = await doc.reference.collection('services').get();
        _servicesCache![doc.id] = servicesSnap.docs
            .map((s) => s.data())
            .toList();
      }
    }

    final q = query.toLowerCase();
    return docs.where((doc) {
      final data = doc.data() as Map<String, dynamic>? ?? {};

      // Search customer-level fields: name, address, phone, ro_type
      final name = (data['name'] as String? ?? '').toLowerCase();
      final address = (data['address'] as String? ?? '').toLowerCase();
      final phone =
          (data['number'] as String? ?? data['phone'] as String? ?? '')
              .toLowerCase();
      final roType = (data['ro_type'] as String? ?? '')
          .toLowerCase();

      if (name.contains(q) ||
          address.contains(q) ||
          phone.contains(q) ||
          roType.contains(q)) {
        return true;
      }

      // Search service-level fields (except amount, duration, equipment)
      final services = _servicesCache?[doc.id] ?? [];
      for (var svc in services) {
        final serviceType =
            (svc['serviceType'] as String? ??
                    svc['service_type'] as String? ??
                    '')
                .toLowerCase();
        final status = (svc['status'] as String? ?? '').toLowerCase();
        final remarks = (svc['remarks'] as String? ?? '').toLowerCase();
        final serviceDate =
            (svc['serviceDate'] as String? ??
                    svc['service_date'] as String? ??
                    '')
                .toLowerCase();
        final notifDate = (svc['notificationDate'] as String? ?? '')
            .toLowerCase();

        if (serviceType.contains(q) ||
            status.contains(q) ||
            remarks.contains(q) ||
            serviceDate.contains(q) ||
            notifDate.contains(q)) {
          return true;
        }
      }

      return false;
    }).toList();
  }

  Widget _buildCustomerList(
    BuildContext context,
    List<DocumentSnapshot> filtered,
  ) {
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 8),
            Text(
              'No customers found.',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final doc = filtered[index];
        final data = doc.data() as Map<String, dynamic>;
        final name = data['name'] as String? ?? 'Unknown';
        final phone =
            data['number'] as String? ?? data['phone'] as String? ?? 'N/A';
        final address = data['address'] as String? ?? 'No address';
        final roType = data['ro_type'] as String? ?? '';

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          color: Colors.white,
          child: ListTile(
            onTap: () {
              context.push('/customers/${doc.id}');
            },
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      phone,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (roType.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        roType,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (phone.isNotEmpty && phone != 'N/A')
                  IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () {
                      PhoneActionHandler.handleAction(
                        context: context,
                        rawNumbers: phone,
                        actionName: 'Call',
                        onSelected: (selectedNumber) async {
                          final url = Uri.parse('tel:$selectedNumber');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                      );
                    },
                  ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}
