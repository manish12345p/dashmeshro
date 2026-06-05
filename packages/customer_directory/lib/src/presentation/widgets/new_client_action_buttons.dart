import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

/// Action buttons: Save Client (primary) and Save & Create Service Entry (secondary).
class NewClientActionButtons extends StatelessWidget {
  final VoidCallback? onSave;
  final VoidCallback? onSaveAndCreateEntry;

  const NewClientActionButtons({
    super.key,
    this.onSave,
    this.onSaveAndCreateEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Save Client Button ──
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [context.colors.primaryDark, context.colors.primary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: context.colors.primaryDark.withOpacity(0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onSave ?? () => Navigator.of(context).pop(),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Save Client',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),

        // ── Save & Create Service Entry ──
        GestureDetector(
          onTap: onSaveAndCreateEntry,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colors.border),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colors.infoBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.miscellaneous_services_rounded,
                    color: context.colors.primary,
                    size: 20,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Save and Create Visit Entry',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: context.colors.textTertiary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
