import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';

class PhoneActionHandler {
  /// Handles an action that requires a phone number.
  /// If there's 1 number, it executes immediately.
  /// If there are multiple, it shows a bottom sheet for the user to choose.
  static void handleAction({
    required BuildContext context,
    required String rawNumbers,
    required String actionName,
    required Function(String) onSelected,
  }) {
    final numbers = PhoneUtils.parsePhoneNumbers(rawNumbers);

    if (numbers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No valid phone numbers available')),
      );
      return;
    }

    if (numbers.length == 1) {
      onSelected(numbers.first);
      return;
    }

    // Multiple numbers found. Show selection sheet.
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Select number to $actionName',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ctx.colors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...numbers.map((num) => ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      leading: Icon(
                        actionName.toLowerCase() == 'whatsapp'
                            ? Icons.chat
                            : actionName.toLowerCase() == 'copy'
                                ? Icons.copy
                                : Icons.call,
                        color: actionName.toLowerCase() == 'whatsapp'
                            ? ctx.colors.success
                            : ctx.colors.primary,
                      ),
                      title: Text(
                        num,
                        style: TextStyle(
                          fontSize: 16,
                          color: ctx.colors.textPrimary,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        onSelected(num);
                      },
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
