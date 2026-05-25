import 'package:flutter/material.dart';

/// Security and Cloud Sync info cards shown at the bottom.
class NewClientInfoCards extends StatelessWidget {
  const NewClientInfoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Security card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0D2137), Color(0xFF1A3A5C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SECURITY',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF94A3B8),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.shield_rounded, color: Colors.white, size: 24),
                const SizedBox(height: 8),
                Text(
                  'Data encrypted\nand stored\nsecurely.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFCBD5E1),
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        // Cloud Sync card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CLOUD SYNC',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF2F80ED),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.cloud_sync_rounded, color: Color(0xFF2F80ED), size: 24),
                const SizedBox(height: 8),
                Text(
                  'Auto-synced\nacross all your\ndevices.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF475569),
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
