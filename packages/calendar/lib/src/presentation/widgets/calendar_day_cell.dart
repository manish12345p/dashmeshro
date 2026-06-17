import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class CalendarDayCell extends StatelessWidget {
  final int dayNumber;
  final bool isGreyedOut;
  final bool isSelected;
  final bool hasAmcDot;
  final bool hasRentDot;
  final bool isDueDate; // highlights this day as a service due date
  final VoidCallback? onTap;

  const CalendarDayCell({
    super.key,
    required this.dayNumber,
    this.isGreyedOut = false,
    this.isSelected = false,
    this.hasAmcDot = false,
    this.hasRentDot = false,
    this.isDueDate = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Due-date highlight colour: amber/orange
    const dueColor = Color(0xFFF59E0B);

    return GestureDetector(
      onTap: isGreyedOut ? null : onTap,
      child: SizedBox(
        width: 32,
        height: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                // Fill: blue when selected, transparent otherwise
                color: isSelected ? context.colors.primary : Colors.transparent,
                shape: BoxShape.circle,
                // Ring: amber when due date and NOT selected
                border: isDueDate && !isSelected
                    ? Border.all(color: dueColor, width: 2)
                    : null,
              ),
              child: Center(
                child: Text(
                  '$dayNumber',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: (isSelected || isDueDate)
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isGreyedOut
                        ? context.colors.textTertiary
                        : isSelected
                        ? Colors.white
                        : isDueDate
                        ? dueColor
                        : context.colors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            // Dots under the number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSelected)
                  Container(
                    width: 3,
                    height: 3,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  )
                else ...[
                  if (hasAmcDot)
                    Container(
                      width: 3,
                      height: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (hasRentDot)
                    Container(
                      width: 3,
                      height: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: context.colors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (isDueDate && !hasAmcDot && !hasRentDot)
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: dueColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
