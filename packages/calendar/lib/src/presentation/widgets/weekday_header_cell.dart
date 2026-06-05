import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class WeekdayHeaderCell extends StatelessWidget {
  final String text;
  const WeekdayHeaderCell({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: context.colors.textTertiary,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
