import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/customer.dart';

class ProfileHeaderCard extends StatelessWidget {
  final Customer customer;

  const ProfileHeaderCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: context.colors.textSecondary.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p24),
        child: Column(
          children: [
            // Removed Image and Badge, jumping straight to name
            Text(
              customer.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  customer.role,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.colors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Contact Info Fields
            Row(
              children: [
                Icon(Icons.phone, size: 18, color: context.colors.primaryDark),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    customer.number,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.colors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: context.colors.primary),
                  tooltip: 'Add another number',
                  onPressed: () {
                    final controller = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Add Phone Number'),
                        content: TextField(
                          controller: controller,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'New Phone Number',
                            hintText: 'e.g. 9876543210',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final newNumber = controller.text.trim();
                              if (newNumber.isNotEmpty) {
                                final updatedNumber = customer.number.isEmpty ? newNumber : '${customer.number}, $newNumber';
                                FirebaseFirestore.instance.collection('Customer').doc(customer.id).update({'number': updatedNumber});
                                Navigator.pop(dialogContext);
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chat, color: context.colors.success),
                  onPressed: () async {
                    final rawNumber = customer.number.split(',').first.trim();
                    final cleanNum = rawNumber.replaceAll(RegExp(r'[^0-9]'), '');
                    final finalNum = cleanNum.length == 10 ? '91$cleanNum' : cleanNum;
                    final url = Uri.parse('https://wa.me/$finalNum');
                    try {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } catch (e) {
                      debugPrint('Could not launch WhatsApp: $e');
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildContactRow(context, Icons.location_on_outlined, customer.address, isMultiline: true),
            SizedBox(height: 12),
            _buildContactRow(context, Icons.water_drop_outlined, customer.roType.isNotEmpty ? customer.roType : 'N/A'),
            if (customer.note.isNotEmpty) ...[
              SizedBox(height: 12),
              _buildContactRow(context, Icons.note_alt_outlined, customer.note, isMultiline: true),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String text, {bool isMultiline = false}) {
    return Row(
      crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: context.colors.primaryDark),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: context.colors.textPrimary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
