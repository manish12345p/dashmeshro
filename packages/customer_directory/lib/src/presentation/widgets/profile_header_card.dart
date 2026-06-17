import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core/core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/customer.dart';
import 'ro_type_dropdown.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    customer.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      final controller = TextEditingController(text: customer.name);
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Edit Name'),
                          content: TextField(
                            controller: controller,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter customer name',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final newName = controller.text.trim();
                                if (newName.isNotEmpty) {
                                  FirebaseFirestore.instance
                                      .collection('Customer')
                                      .doc(customer.id)
                                      .update({'name': newName});
                                  Navigator.pop(dialogContext);
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.edit, size: 20, color: context.colors.primary),
                    ),
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
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
                                  final updatedNumber = customer.number.isEmpty
                                      ? newNumber
                                      : '${customer.number}, $newNumber';
                                  FirebaseFirestore.instance
                                      .collection('Customer')
                                      .doc(customer.id)
                                      .update({'number': updatedNumber});
                                  Navigator.pop(dialogContext);
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: context.colors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final url = PhoneUtils.getWhatsAppUri(customer.number);
                      if (url == null) return;
                      try {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } catch (e) {
                        debugPrint('Could not launch WhatsApp: $e');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.chat, size: 20, color: context.colors.success),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildContactRow(
              context,
              Icons.location_on_outlined,
              customer.address,
              isMultiline: true,
              onEdit: () {
                final controller = TextEditingController(text: customer.address);
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Edit Address'),
                    content: TextField(
                      controller: controller,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        hintText: 'Enter full address',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final newAddress = controller.text.trim();
                          if (newAddress.isNotEmpty) {
                            FirebaseFirestore.instance
                                .collection('Customer')
                                .doc(customer.id)
                                .update({'address': newAddress});
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
            SizedBox(height: 12),
            _buildContactRow(
              context,
              Icons.map_outlined,
              customer.locality.isEmpty ? 'No locality added' : customer.locality,
              onEdit: () {
                final controller = TextEditingController(text: customer.locality);
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Edit Locality'),
                    content: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: 'Locality',
                        hintText: 'Enter locality',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final newLocality = controller.text.trim();
                          FirebaseFirestore.instance
                              .collection('Customer')
                              .doc(customer.id)
                              .update({'locality': newLocality});
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            _buildRoTypeSection(context),
            SizedBox(height: 12),
            _buildContactRow(
              context,
              Icons.note_alt_outlined,
              customer.note.isEmpty ? 'No internal note added' : customer.note,
              isMultiline: true,
              onEdit: () {
                final controller = TextEditingController(text: customer.note);
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Edit Internal Note'),
                    content: TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Internal Note',
                        hintText: 'Enter internal note or remarks',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final newNote = controller.text.trim();
                          FirebaseFirestore.instance
                              .collection('Customer')
                              .doc(customer.id)
                              .update({'note': newNote});
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(
    BuildContext context,
    IconData icon,
    String text, {
    bool isMultiline = false,
    VoidCallback? onEdit,
  }) {
    return Row(
      crossAxisAlignment: isMultiline
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
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
        if (onEdit != null)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onEdit,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.edit, size: 18, color: context.colors.primary),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRoTypeSection(BuildContext context) {
    final roTypes = customer.roType
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.water_drop_outlined,
          size: 18,
          color: context.colors.primaryDark,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (roTypes.isEmpty)
                Text(
                  'N/A',
                  style: TextStyle(
                    fontSize: 13,
                    color: context.colors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ...roTypes.map(
                (ro) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.colors.primaryLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: context.colors.primaryLight.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    ro,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _showRoTypeUpdateDialog(context, roTypes),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.add_circle_outline,
                color: context.colors.primary,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showRoTypeUpdateDialog(
    BuildContext context,
    List<String> currentRoTypes,
  ) {
    String selectedRoType = '';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Update RO Type',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoTypeDropdownWidget(
                initialValue: '',
                onChanged: (val) {
                  selectedRoType = val;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Do you want to add this to the existing devices, or replace them entirely?',
                style: TextStyle(
                  fontSize: 12,
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedRoType.isNotEmpty) {
                  final newRoType = selectedRoType;
                  await FirebaseFirestore.instance
                      .collection('Customer')
                      .doc(customer.id)
                      .update({'ro_type': newRoType});
                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.warning,
              ),
              child: const Text(
                'Replace',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedRoType.isNotEmpty) {
                  final newRoTypes = List<String>.from(currentRoTypes)
                    ..add(selectedRoType);
                  final newRoTypeString = newRoTypes.join(', ');
                  await FirebaseFirestore.instance
                      .collection('Customer')
                      .doc(customer.id)
                      .update({'ro_type': newRoTypeString});
                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
              ),
              child: const Text(
                'Add Extra',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
