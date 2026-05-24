import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/customer.dart';

class StatsGrid extends StatelessWidget {
  final Customer customer;

  const StatsGrid({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppPadding.p12,
      mainAxisSpacing: AppPadding.p12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('TOTAL VISITS', customer.totalVisits.toString(), const Color(0xFFEFF6FF), const Color(0xFF1E3A8A)),
        _buildStatCard('ACTIVE AMC', customer.activeAmc ? 'Yes' : 'No', const Color(0xFFEFF6FF), const Color(0xFF16A34A)),
        _buildStatCard('CUSTOMER VALUE', customer.customerValue, const Color(0xFFEFF6FF), const Color(0xFF1E3A8A)),
        _buildStatCard('OPEN TICKETS', customer.openTickets.toString().padLeft(2, '0'), const Color(0xFFFFF5F5), const Color(0xFFDC2626)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color bg, Color textClr) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF475569),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textClr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
