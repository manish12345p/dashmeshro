import 'package:flutter/material.dart';

/// Reusable header bar with back arrow, title, and avatar.
/// Used on full-screen pages that sit outside the shell (no navbar).
class NewClientHeaderBar extends StatelessWidget {
  const NewClientHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF0D2137),
              size: 22,
            ),
          ),
        ),
        Text(
          'Dashmesh Mechanix',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
                color: const Color(0xFF1E293B),
              ),
        ),
        const CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=150',
          ),
        ),
      ],
    );
  }
}
