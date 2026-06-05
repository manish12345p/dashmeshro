import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/customer.dart';

class StatsGrid extends StatelessWidget {
  final Customer customer;

  const StatsGrid({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: _buildStatCard(
        context,
        'TOTAL VISITS',
        customer.serviceHistory.length.toString(),
        context.colors.infoBg,
        context.colors.primaryDark,
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, Color bg, Color textClr) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: context.colors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 6),
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
