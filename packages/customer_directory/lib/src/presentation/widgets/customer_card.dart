import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    Color badgeBg;
    Color badgeText;
    Color accentColor;

    switch (customer.customerType) {
      case 'Active AMC':
        badgeBg = const Color(0xFFDCFCE7);
        badgeText = const Color(0xFF15803D);
        accentColor = const Color(0xFF16A34A);
        break;
      case 'Rental Customer':
        badgeBg = const Color(0xFFFEF3C7);
        badgeText = const Color(0xFF92400E);
        accentColor = const Color(0xFFD97706);
        break;
      case 'Recent Purchase':
        badgeBg = const Color(0xFFDBEAFE);
        badgeText = const Color(0xFF1E40AF);
        accentColor = const Color(0xFF2563EB);
        break;
      case 'Open Complaint':
      default:
        badgeBg = const Color(0xFFFEE2E2);
        badgeText = const Color(0xFF991B1B);
        accentColor = const Color(0xFFDC2626);
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border(
          left: BorderSide(color: accentColor, width: 5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge & Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    customer.customerType.toUpperCase(),
                    style: TextStyle(
                      color: badgeText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (customer.customerType == 'Active AMC')
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFDCFCE7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, size: 14, color: Color(0xFF15803D)),
                  ),
                if (customer.customerType == 'Recent Purchase')
                  Text(
                    '#${customer.customerId.replaceAll("MCP-", "")}',
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Customer Name & Role
            Text(
              customer.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              customer.role,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),

            // Dynamic card details based on status
            if (customer.customerType == 'Active AMC') ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CONTRACT END',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Dec 2024',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ] else if (customer.customerType == 'Rental Customer') ...[
              Row(
                children: [
                  const Icon(Icons.widgets_outlined, size: 16, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  const Text(
                    '2x Hydro-Pumps',
                    style: TextStyle(fontSize: 13, color: Color(0xFF475569), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  const Text(
                    'Renewal: Oct 12',
                    style: TextStyle(fontSize: 13, color: Color(0xFF475569), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ] else if (customer.customerType == 'Recent Purchase') ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  customer.deviceName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ] else if (customer.customerType == 'Open Complaint') ...[
              Row(
                children: [
                  const Icon(Icons.warning_rounded, size: 16, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    'High Priority',
                    style: TextStyle(fontSize: 13, color: Colors.red.shade700, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5F5),
                  border: Border.all(color: const Color(0xFFFEE2E2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.error_outline_rounded, size: 18, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        customer.note,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade800,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // View Details Button Row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/customers/${customer.id}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (customer.customerType == 'Recent Purchase') ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1E3A8A),
                        side: const BorderSide(color: Color(0xFFDBEAFE)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFFEFF6FF),
                      ),
                      child: const Text(
                        'Invoice',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.share, color: Colors.white, size: 18),
                      onPressed: () {},
                    ),
                  ),
                ],
                if (customer.customerType == 'Open Complaint') ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB91C1C),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Resolve Now',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
