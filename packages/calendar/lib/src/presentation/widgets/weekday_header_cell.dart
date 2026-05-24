import 'package:flutter/material.dart';

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
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black26,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
