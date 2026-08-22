import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

import 'package:go_router/go_router.dart';

/// Reusable header bar with back arrow, title, and avatar.
/// Used on full-screen pages that sit outside the shell (no navbar).
class NewClientHeaderBar extends StatelessWidget {
  const NewClientHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Dashmesh Mechanix',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
            color: context.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
