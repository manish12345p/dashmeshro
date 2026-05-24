import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/customer.dart';

class DeviceCard extends StatelessWidget {
  final Customer customer;

  const DeviceCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'REGISTERED DEVICE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF94A3B8),
                    letterSpacing: 0.8,
                  ),
                ),
                const Icon(Icons.water_drop, color: Colors.blue, size: 24),
              ],
            ),
            const SizedBox(height: 8),

            // Device Name
            Text(
              customer.deviceName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Installed & Last Service details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDeviceStat('Installed On', customer.deviceInstalledOn),
                _buildDeviceStat('Last Service', customer.deviceLastService),
              ],
            ),
            const SizedBox(height: 20),

            // Filter Health Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Health',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
                Text(
                  '${(customer.deviceFilterHealth * 100).toInt()}%',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: customer.deviceFilterHealth,
                backgroundColor: Colors.white10,
                color: const Color(0xFF10B981),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white60),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
