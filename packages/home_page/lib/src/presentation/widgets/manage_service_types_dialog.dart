import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_ui/core_ui.dart';

class ManageServiceTypesDialog extends StatefulWidget {
  const ManageServiceTypesDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const ManageServiceTypesDialog(),
    );
  }

  @override
  State<ManageServiceTypesDialog> createState() => _ManageServiceTypesDialogState();
}

class _ManageServiceTypesDialogState extends State<ManageServiceTypesDialog> {
  final TextEditingController _controller = TextEditingController();
  List<String> _serviceTypes = [];
  bool _isLoading = true;
  String? _docId;
  String _arrayFieldName = 'types'; // default

  @override
  void initState() {
    super.initState();
    _fetchServiceTypes();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchServiceTypes() async {
    setState(() => _isLoading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('ServiceType')
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        _docId = doc.id;
        final data = doc.data();
        
        for (final entry in data.entries) {
          if (entry.value is Iterable) {
            _arrayFieldName = entry.key;
            _serviceTypes = List<String>.from(entry.value);
            break;
          }
        }
      } else {
        // Create initial document
        final newDoc = await FirebaseFirestore.instance
            .collection('ServiceType')
            .add({'types': [
              'Set Change', 'AMC', 'New RO', 'Repair', 'Service', 'Pump',
              'Set Pump', 'New RO Set Change', 'Set SV', 'Install and Set Change',
              'Set & Pump', 'Inline', 'Copper Set', 'Alkaline', 'Alkaline Set',
              'Set SMPS', 'Not Applicable',
            ]});
        _docId = newDoc.id;
        _arrayFieldName = 'types';
        _serviceTypes = [
          'Set Change', 'AMC', 'New RO', 'Repair', 'Service', 'Pump',
          'Set Pump', 'New RO Set Change', 'Set SV', 'Install and Set Change',
          'Set & Pump', 'Inline', 'Copper Set', 'Alkaline', 'Alkaline Set',
          'Set SMPS', 'Not Applicable',
        ];
      }
    } catch (e) {
      debugPrint('Error fetching Service types: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _addServiceType() async {
    final newType = _controller.text.trim();
    if (newType.isEmpty) return;
    if (_serviceTypes.contains(newType)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service Type already exists')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_docId != null) {
        await FirebaseFirestore.instance
            .collection('ServiceType')
            .doc(_docId)
            .update({
              _arrayFieldName: FieldValue.arrayUnion([newType])
            });
      }
      _controller.clear();
      await _fetchServiceTypes();
    } catch (e) {
      debugPrint('Error adding Service type: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteServiceType(String type) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service Type'),
        content: Text('Are you sure you want to delete "$type"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: context.colors.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);
    try {
      if (_docId != null) {
        await FirebaseFirestore.instance
            .collection('ServiceType')
            .doc(_docId)
            .update({
              _arrayFieldName: FieldValue.arrayRemove([type])
            });
      }
      await _fetchServiceTypes();
    } catch (e) {
      debugPrint('Error deleting Service type: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: context.colors.surface,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.category, color: context.colors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Manage Service Types',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Enter new service type',
                      filled: true,
                      fillColor: context.colors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: _isLoading ? null : _addServiceType,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Flexible(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _serviceTypes.isEmpty
                      ? const Center(child: Text('No service types found'))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _serviceTypes.length,
                          itemBuilder: (context, index) {
                            final type = _serviceTypes[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                type,
                                style: TextStyle(
                                  color: context.colors.textPrimary,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: context.colors.error,
                                  size: 20,
                                ),
                                onPressed: () => _deleteServiceType(type),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
