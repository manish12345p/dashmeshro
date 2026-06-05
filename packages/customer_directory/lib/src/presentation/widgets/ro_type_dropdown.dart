import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_ui/core_ui.dart';

class RoTypeDropdownWidget extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const RoTypeDropdownWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<RoTypeDropdownWidget> createState() => _RoTypeDropdownWidgetState();
}

class _RoTypeDropdownWidgetState extends State<RoTypeDropdownWidget> {
  List<String> _roTypes = [];
  bool _isLoading = true;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue.isEmpty ? null : widget.initialValue;
    _fetchRoTypes();
  }

  Future<void> _fetchRoTypes() async {
    try {
      // The RoType collection has a single doc with an array field
      final snapshot = await FirebaseFirestore.instance
          .collection('RoType')
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        // Find the first array value in the document
        for (final value in data.values) {
          if (value is Iterable) {
            _roTypes = List<String>.from(value);
            break;
          }
        }
      }

      // Fallback defaults if nothing found
      if (_roTypes.isEmpty) {
        _roTypes = ['Commercial', 'Domestic', 'Industrial'];
      }

      // If initialValue isn't in the list, clear it
      if (_selectedValue != null && !_roTypes.contains(_selectedValue)) {
        _selectedValue = null;
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _roTypes = ['Commercial', 'Domestic', 'Industrial'];
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: 56,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return DropdownButtonFormField<String>(
      value: _selectedValue,
      borderRadius: BorderRadius.circular(20),
      hint: Text('Select RO Type'),
      items: _roTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (val) {
        if (val != null) {
          setState(() {
            _selectedValue = val;
          });
          widget.onChanged(val);
        }
      },
      decoration: InputDecoration(
        labelText: 'RO Type',
        labelStyle: TextStyle(color: context.colors.textSecondary, fontSize: 14),
        prefixIcon: Icon(Icons.water_drop_rounded, color: context.colors.primary),
        filled: true,
        fillColor: context.colors.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.primary, width: 1.5),
        ),
      ),
    );
  }
}
