import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const NotificationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.85,
          child: Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: const Color(0xFF003366),
              title: const Row(
                children: [
                  Icon(Icons.notifications_active, color: Colors.white, size: 22),
                  SizedBox(width: 8),
                  Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
            ),
            body: _NotificationBody(),
          ),
        ),
      ),
    );
  }
}

class _NotificationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Customer').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return FutureBuilder<_NotificationData>(
          future: _processData(snapshot.data!),
          builder: (context, asyncSnap) {
            if (!asyncSnap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = asyncSnap.data!;
            final hasExpiry = data.expiringItems.isNotEmpty;
            final hasOverdue = data.overduePayments.isNotEmpty;

            if (!hasExpiry && !hasOverdue) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 16),
                    const Text(
                      'No notifications for today',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF003366)),
                    ),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Expiring Durations Section
                if (hasExpiry) ...[
                  _buildSectionHeader(
                    icon: Icons.timer_off_outlined,
                    title: 'Expiring Durations',
                    count: data.expiringItems.length,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  ...data.expiringItems.map((item) => _buildExpiryCard(context, item)),
                  const SizedBox(height: 24),
                ],

                // Overdue Payments Section
                if (hasOverdue) ...[
                  _buildSectionHeader(
                    icon: Icons.payment_outlined,
                    title: 'Overdue Payments',
                    count: data.overduePayments.length,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 12),
                  ...data.overduePayments.map((item) => _buildOverdueCard(context, item)),
                ],
              ],
            );
          },
        );
      },
    );
  }

  Future<_NotificationData> _processData(QuerySnapshot customersSnap) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final List<_ExpiryInfo> expiringItems = [];
    final List<_OverdueInfo> overduePayments = [];
    final Map<String, String> customerPhones = {};

    for (var customerDoc in customersSnap.docs) {
      final customerData = customerDoc.data() as Map<String, dynamic>;
      final customerName = customerData['name'] as String? ?? 'Unknown';
      final phone = customerData['number'] as String? ?? '';
      customerPhones[customerDoc.id] = phone;

      final servicesSnap = await customerDoc.reference.collection('services').get();

      for (var serviceDoc in servicesSnap.docs) {
        final data = serviceDoc.data();
        final serviceType = data['serviceType'] as String? ?? data['service_type'] as String? ?? 'Service';
        final dateStr = data['serviceDate'] as String? ?? data['service_date'] as String? ?? '';
        final serviceDuration = data['serviceDuration'] as String? ?? '';
        final guaranteeDuration = data['guaranteeDuration'] as String? ?? '';

        DateTime? serviceDate;
        try {
          if (dateStr.isNotEmpty) serviceDate = DateTime.parse(dateStr);
        } catch (_) {}

        // Check service duration expiry
        if (serviceDate != null && serviceDuration.isNotEmpty) {
          final expiry = _calculateExpiry(serviceDate, serviceDuration);
          if (expiry != null) {
            final daysLeft = expiry.difference(today).inDays;
            // Show if expiring within 2 days or already expired (up to 30 days ago)
            if (daysLeft <= 2 && daysLeft >= -30) {
              expiringItems.add(_ExpiryInfo(
                customerName: customerName,
                customerId: customerDoc.id,
                phone: phone,
                type: 'Service Duration',
                serviceType: serviceType,
                expiryDate: expiry,
                daysLeft: daysLeft,
                duration: serviceDuration,
              ));
            }
          }
        }

        // Check guarantee/client duration expiry
        if (serviceDate != null && guaranteeDuration.isNotEmpty) {
          final expiry = _calculateExpiry(serviceDate, guaranteeDuration);
          if (expiry != null) {
            final daysLeft = expiry.difference(today).inDays;
            if (daysLeft <= 2 && daysLeft >= -30) {
              expiringItems.add(_ExpiryInfo(
                customerName: customerName,
                customerId: customerDoc.id,
                phone: phone,
                type: 'Client Duration',
                serviceType: serviceType,
                expiryDate: expiry,
                daysLeft: daysLeft,
                duration: guaranteeDuration,
              ));
            }
          }
        }
      }
    }

    // Now fetch overdue payments from installments
    final installmentsSnap = await FirebaseFirestore.instance.collection('installments').get();
    
    for (var doc in installmentsSnap.docs) {
      final data = doc.data();
      final status = data['status'] as String? ?? 'pending';
      if (status == 'paid') continue;
      
      final amountPending = (data['amount'] as num?)?.toDouble() ?? 0.0;
      if (amountPending <= 0) continue;

      final dueDateStr = data['due_date'] as String? ?? '';
      DateTime? dueDate;
      try {
        if (dueDateStr.isNotEmpty) dueDate = DateTime.parse(dueDateStr);
      } catch (_) {}

      // Show if due date is today or in the past
      if (dueDate != null && dueDate.isBefore(today.add(const Duration(days: 1)))) {
        final customerName = data['customer_name'] as String? ?? 'Unknown';
        final customerId = data['customer_id'] as String? ?? '';
        final phone = customerPhones[customerId] ?? '';
        final serviceType = data['service_name'] as String? ?? 'EMI';

        overduePayments.add(_OverdueInfo(
          customerName: customerName,
          customerId: customerId,
          phone: phone,
          amountPending: amountPending,
          dueDate: dueDate,
          serviceType: serviceType,
          daysOverdue: today.difference(dueDate).inDays,
        ));
      }
    }

    // Sort: most urgent first
    expiringItems.sort((a, b) => a.daysLeft.compareTo(b.daysLeft));
    overduePayments.sort((a, b) => b.daysOverdue.compareTo(a.daysOverdue));

    return _NotificationData(expiringItems: expiringItems, overduePayments: overduePayments);
  }

  DateTime? _calculateExpiry(DateTime startDate, String durationStr) {
    try {
      final parts = durationStr.split(' ');
      if (parts.length != 2) return null;
      final value = int.tryParse(parts[0]) ?? 0;
      final unit = parts[1].toLowerCase();

      if (unit.contains('month')) {
        return DateTime(startDate.year, startDate.month + value, startDate.day);
      } else if (unit.contains('year')) {
        return DateTime(startDate.year + value, startDate.month, startDate.day);
      } else if (unit.contains('day')) {
        return startDate.add(Duration(days: value));
      }
    } catch (_) {}
    return null;
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required int count,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('$count', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      ],
    );
  }

  Widget _buildExpiryCard(BuildContext context, _ExpiryInfo item) {
    final isExpired = item.daysLeft < 0;
    final statusColor = isExpired ? Colors.red : Colors.orange;
    final statusText = isExpired
        ? '${item.daysLeft.abs()} days ago expired'
        : item.daysLeft == 0
            ? 'Expires today!'
            : '${item.daysLeft} day(s) remaining';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).pop();
          context.push('/customers/${item.customerId}');
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.customerName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.build_circle_outlined, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text('${item.type} (${item.serviceType})', style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Duration: ${item.duration} | Expiry: ${item.expiryDate.toIso8601String().split('T')[0]}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverdueCard(BuildContext context, _OverdueInfo item) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).pop();
          context.push('/customers/${item.customerId}');
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.customerName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '₹${item.amountPending.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.category_outlined, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(item.serviceType, style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.warning_amber_outlined, size: 14, color: Colors.red.shade400),
                  const SizedBox(width: 4),
                  Text(
                    item.dueDate != null
                        ? 'Due: ${item.dueDate!.toIso8601String().split('T')[0]} (${item.daysOverdue} days overdue)'
                        : 'Payment pending (no due date set)',
                    style: TextStyle(fontSize: 12, color: Colors.red.shade400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationData {
  final List<_ExpiryInfo> expiringItems;
  final List<_OverdueInfo> overduePayments;
  _NotificationData({required this.expiringItems, required this.overduePayments});
}

class _ExpiryInfo {
  final String customerName, customerId, phone, type, serviceType, duration;
  final DateTime expiryDate;
  final int daysLeft;
  _ExpiryInfo({
    required this.customerName, required this.customerId, required this.phone,
    required this.type, required this.serviceType, required this.expiryDate,
    required this.daysLeft, required this.duration,
  });
}

class _OverdueInfo {
  final String customerName, customerId, phone, serviceType;
  final double amountPending;
  final DateTime? dueDate;
  final int daysOverdue;
  _OverdueInfo({
    required this.customerName, required this.customerId, required this.phone,
    required this.amountPending, required this.dueDate, required this.serviceType,
    required this.daysOverdue,
  });
}
