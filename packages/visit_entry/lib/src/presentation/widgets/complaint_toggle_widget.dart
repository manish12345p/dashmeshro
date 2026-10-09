import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import '../bloc/visit_entry_bloc.dart';
import '../bloc/visit_entry_event.dart';

class ComplaintToggleWidget extends StatelessWidget {
  const ComplaintToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitEntryBloc, VisitEntryState>(
      buildWhen: (prev, curr) => prev.isComplaint != curr.isComplaint,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: state.isComplaint
                ? context.colors.error.withOpacity(0.05)
                : context.colors.surface,
            border: Border.all(
              color: state.isComplaint
                  ? context.colors.error.withOpacity(0.3)
                  : context.colors.border,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: state.isComplaint
                        ? context.colors.error
                        : context.colors.textSecondary,
                    size: 22,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Is this a Complaint?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: state.isComplaint
                          ? context.colors.error
                          : context.colors.textPrimary,
                    ),
                  ),
                ],
              ),
              Switch(
                value: state.isComplaint,
                activeColor: context.colors.error,
                onChanged: (value) {
                  context.read<VisitEntryBloc>().add(
                    ToggleComplaint(value),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
