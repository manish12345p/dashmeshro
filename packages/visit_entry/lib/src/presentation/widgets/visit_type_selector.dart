import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> _serviceTypes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    debugPrint('ServiceType loading flag set to true');
    _fetchServiceTypes();
  }

  Future<void> _fetchServiceTypes() async {
    debugPrint('ServiceType options requested');
    // Minimal fix: Removed hanging Firebase request. Load fallback immediately.
    setState(() {
      _serviceTypes = [
        'Set Change', 'AMC', 'New RO', 'Repair', 'Service', 'Pump',
        'Set Pump', 'New RO Set Change', 'Set SV', 'Install and Set Change',
        'Set & Pump', 'Inline', 'Copper Set', 'Alkaline', 'Alkaline Set',
        'Set SMPS', 'Not Applicable',
      ];
      _isLoading = false;
    });
    debugPrint('ServiceType request completed');
    debugPrint('ServiceType options loaded');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: context.colors.textSecondary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
    if (_isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return BlocBuilder<VisitEntryBloc, VisitEntryState>(
      buildWhen: (previous, current) =>
          previous.serviceType != current.serviceType ||
          previous.remainingAmcVisits != current.remainingAmcVisits ||
          previous.totalAmcVisitsToPurchase != current.totalAmcVisitsToPurchase,
      builder: (context, state) {
        final selectedList = state.serviceType
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _serviceTypes.map((type) {
                final isSelected = selectedList.contains(type);
                return FilterChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      selectedList.add(type);
                    } else {
                      selectedList.remove(type);
                    }
                    context.read<VisitEntryBloc>().add(
                          SelectServiceType(selectedList.join(', ')),
                        );
                  },
                  selectedColor: context.colors.primary.withValues(alpha: 0.2),
                  checkmarkColor: context.colors.primary,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? context.colors.primaryDark
                        : context.colors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  backgroundColor: context.colors.surfaceSecondary,
                  side: BorderSide(
                    color: isSelected
                        ? context.colors.primary
                        : context.colors.border,
                  ),
                );
              }).toList(),
            ),
            // ...[
            //   SizedBox(height: 16),
            //   if (state.remainingAmcVisits > 0)
            //     Container(
            //       padding: EdgeInsets.all(12),
            //       decoration: BoxDecoration(
            //         color: context.colors.warning.withValues(alpha: 0.1),
            //         borderRadius: BorderRadius.circular(12),
            //         border: Border.all(color: context.colors.warning),
            //       ),
            //       child: Row(
            //         children: [
            //           Icon(Icons.info_outline, color: context.colors.warning, size: 20),
            //           SizedBox(width: 8),
            //           Expanded(
            //             child: Text(
            //               'Remaining AMC visits: ${state.remainingAmcVisits}. This visit will consume 1.',
            //               style: TextStyle(
            //                 color: context.colors.warning,
            //                 fontSize: 13,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            //   else
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'This customer has 0 ${state.serviceType} visits remaining. If they are purchasing a new ${state.serviceType}, enter the number of visits:',
            //           style: TextStyle(
            //             fontSize: 13,
            //             color: context.colors.textSecondary,
            //           ),
            //         ),
            //         SizedBox(height: 8),
            //         TextField(
            //           keyboardType: TextInputType.number,
            //           onChanged: (value) {
            //             context.read<VisitEntryBloc>().add(
            //               UpdateTotalAmcVisitsToPurchase(int.tryParse(value) ?? 0),
            //             );
            //           },
            //           decoration: InputDecoration(
            //             hintText: 'e.g. 3 or 4',
            //             filled: true,
            //             fillColor: context.colors.background,
            //             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(12),
            //               borderSide: BorderSide.none,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            // ],
          ],
        );
      },
    );
  }
}
