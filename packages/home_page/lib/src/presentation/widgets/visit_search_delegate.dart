import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:core_ui/core_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitSearchDelegate extends SearchDelegate<String?> {
  // Cache the future so we only fetch from Supabase once per search session
  Future<List<Map<String, dynamic>>>? _customersFuture;

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
    _customersFuture ??= _fetchCustomersWithServices();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _customersFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!;

        if (query.isEmpty) {
          // Show all customers when no query
          return _buildCustomerList(context, docs);
        }

        return _buildCustomerList(context, _filterWithServices(docs));
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchCustomersWithServices() async {
    final response = await Supabase.instance.client
        .from('customers')
        .select('*, services(*)');
    return List<Map<String, dynamic>>.from(response as List);
  }

  List<Map<String, dynamic>> _filterWithServices(
    List<Map<String, dynamic>> docs,
  ) {
    final q = query.toLowerCase();
    return docs.where((doc) {
      final data = doc;

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
      final services = (data['services'] as List<dynamic>? ?? []);
      for (var svcDyn in services) {
        final svc = svcDyn as Map<String, dynamic>;
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
    List<Map<String, dynamic>> filtered,
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
        final data = doc;
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
              context.push('/customers/${data['id']}');
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
