import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Save as Draft - subtle text button
        Center(
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
              textStyle: const TextStyle(
                fontSize: 14,
              ),
            ),
            child: const Text('Save as Draft'),
          ),
        ),
        const SizedBox(height: 8),
        // Commit Entry - full-width gradient button
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0D2137),
                  Color(0xFF1A3A5C),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Commit Entry',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent.shade400,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
