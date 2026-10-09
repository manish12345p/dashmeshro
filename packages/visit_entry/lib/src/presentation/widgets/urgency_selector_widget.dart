import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import '../bloc/visit_entry_bloc.dart';
import '../bloc/visit_entry_event.dart';

class UrgencySelectorWidget extends StatelessWidget {
  const UrgencySelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitEntryBloc, VisitEntryState>(
      buildWhen: (previous, current) => previous.isUrgent != current.isUrgent,
      builder: (context, state) {
        return Card(
          elevation: 2,
          shadowColor: context.colors.textSecondary.withOpacity(0.08),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: context.colors.surface,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.colors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: context.colors.error,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Is it urgent?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.colors.primaryDark,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                CupertinoSwitch(
                  value: state.isUrgent,
                  activeTrackColor: context.colors.error,
                  onChanged: (val) {
                    context.read<VisitEntryBloc>().add(ToggleUrgency(val));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
