import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_ui/core_ui.dart';

class ManageRoTypesDialog extends StatefulWidget {
  const ManageRoTypesDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const ManageRoTypesDialog(),
    );
  }

  @override
  State<ManageRoTypesDialog> createState() => _ManageRoTypesDialogState();
}

class _ManageRoTypesDialogState extends State<ManageRoTypesDialog> {
  final TextEditingController _controller = TextEditingController();
  List<String> _roTypes = [];
  bool _isLoading = true;
  String? _docId;
  String _arrayFieldName = 'types'; // default

  @override
  void initState() {
    super.initState();
    _fetchRoTypes();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchRoTypes() async {
    setState(() => _isLoading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('RoType')
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        _docId = doc.id;
        final data = doc.data();
        
        for (final entry in data.entries) {
          if (entry.value is Iterable) {
            _arrayFieldName = entry.key;
            _roTypes = List<String>.from(entry.value);
            break;
          }
        }
      } else {
        // Create initial document
        final newDoc = await FirebaseFirestore.instance
            .collection('RoType')
            .add({'types': ['Commercial', 'Domestic', 'Industrial']});
        _docId = newDoc.id;
        _arrayFieldName = 'types';
        _roTypes = ['Commercial', 'Domestic', 'Industrial'];
      }
    } catch (e) {
      debugPrint('Error fetching RO types: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _addRoType() async {
    final newType = _controller.text.trim();
    if (newType.isEmpty) return;
    if (_roTypes.contains(newType)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('RO Type already exists')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_docId != null) {
        await FirebaseFirestore.instance
            .collection('RoType')
            .doc(_docId)
            .update({
              _arrayFieldName: FieldValue.arrayUnion([newType])
            });
      }
      _controller.clear();
      await _fetchRoTypes();
    } catch (e) {
      debugPrint('Error adding RO type: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _removeRoType(String typeToRemove) async {
    setState(() => _isLoading = true);
    try {
      if (_docId != null) {
        await FirebaseFirestore.instance
            .collection('RoType')
            .doc(_docId)
            .update({
              _arrayFieldName: FieldValue.arrayRemove([typeToRemove])
            });
      }
      await _fetchRoTypes();
    } catch (e) {
      debugPrint('Error removing RO type: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p20),
        constraints: const BoxConstraints(maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Manage RO Types',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: AppPadding.p16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add new RO type',
                      filled: true,
                      fillColor: context.colors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colors.border),
                      ),
                    ),
                    onSubmitted: (_) => _addRoType(),
                  ),
                ),
                const SizedBox(width: AppPadding.p12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _addRoType,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.primary,
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: AppPadding.p16),
            const Divider(),
            if (_isLoading && _roTypes.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_roTypes.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: Text('No RO Types found')),
              )
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _roTypes.length,
                  itemBuilder: (context, index) {
                    final type = _roTypes[index];
                    return ListTile(
                      title: Text(type),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          // Confirm dialog
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Remove RO Type?'),
                              content: Text('Are you sure you want to remove "$type"?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                    _removeRoType(type);
                                  },
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
