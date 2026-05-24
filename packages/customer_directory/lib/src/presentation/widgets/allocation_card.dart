import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class AllocationCard extends StatelessWidget {
  const AllocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FLEET RESOURCE ALLOCATION',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 16),

            // Visual linear allocation bar
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                height: 10,
                child: Row(
                  children: [
                    Expanded(flex: 45, child: Container(color: const Color(0xFF16A34A))),
                    Expanded(flex: 30, child: Container(color: const Color(0xFF1E3A8A))),
                    Expanded(flex: 15, child: Container(color: const Color(0xFFF59E0B))),
                    Expanded(flex: 10, child: Container(color: const Color(0xFFDC2626))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Legend Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3.5,
              children: [
                _buildLegendItem('AMC Support\n(45%)', const Color(0xFF16A34A)),
                _buildLegendItem('Rental Fleet\n(30%)', const Color(0xFF1E3A8A)),
                _buildLegendItem('System Buffer\n(15%)', const Color(0xFFF59E0B)),
                _buildLegendItem('Repairs\n(10%)', const Color(0xFFDC2626)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1E293B),
              height: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
