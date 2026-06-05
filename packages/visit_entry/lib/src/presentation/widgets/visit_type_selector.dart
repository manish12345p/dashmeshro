import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import '../bloc/visit_entry_bloc.dart';
import '../bloc/visit_entry_event.dart';

class ServiceTypeSelectorWidget extends StatefulWidget {
  const ServiceTypeSelectorWidget({super.key});

  @override
  State<ServiceTypeSelectorWidget> createState() =>
      _ServiceTypeSelectorWidgetState();
}

class _ServiceTypeSelectorWidgetState extends State<ServiceTypeSelectorWidget> {
  static const List<String> _serviceTypes = [
    'Set Change',
    'AMC',
    'New RO',
    'Repair',
    'Service',
    'Pump',
    'Set Pump',
    'New RO Set Change',
    'Set SV',
    'Install and Set Change',
    'Set & Pump',
    'Inline',
    'Copper Set',
    'Alkaline',
    'Alkaline Set',
    'Set SMPS',
    'Not Applicable'
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: context.colors.textSecondary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: context.colors.surface,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: 20),
            _buildCustomerTypeGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.category_rounded,
            color: context.colors.primary,
            size: 20,
          ),
        ),
        SizedBox(width: 12),
        Text(
          'Service Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: context.colors.primaryDark,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerTypeGrid() {
    return BlocBuilder<VisitEntryBloc, VisitEntryState>(
      buildWhen: (previous, current) => previous.serviceType != current.serviceType,
      builder: (context, state) {
        String? selectedValue;
        if (state.serviceType.isNotEmpty && _serviceTypes.contains(state.serviceType)) {
          selectedValue = state.serviceType;
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select Service Type'),
              value: selectedValue,
              borderRadius: BorderRadius.circular(20),
              icon: Icon(Icons.arrow_drop_down_rounded, color: context.colors.primary),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  context.read<VisitEntryBloc>().add(SelectServiceType(newValue));
                }
              },
              items: _serviceTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
