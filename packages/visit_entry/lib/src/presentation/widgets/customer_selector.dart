import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/visit_entry_bloc.dart';
import '../bloc/visit_entry_event.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/repositories/visit_repository_interface.dart';

/// Step 1 – Identify Customer
/// A premium card widget with a search field for finding customers
/// by name or phone number.
class CustomerSelectorWidget extends StatelessWidget {
  const CustomerSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colors.primary;
    final darkPrimary = context.colors.primaryDark;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.colors.textSecondary.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Row ──────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person_search_rounded,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '1. Identify Customer',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: darkPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // ── Label ───────────────────────────────────────────
            Text(
              'SEARCH CUSTOMER NAME OR PHONE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: context.colors.textTertiary,
                letterSpacing: 1.0,
              ),
            ),

            SizedBox(height: 10),

            // ── Search Field ────────────────────────────────────
            Autocomplete<Map<String, dynamic>>(
              optionsBuilder: (TextEditingValue textEditingValue) async {
                final bloc = context.read<VisitEntryBloc>();
                if (textEditingValue.text.isEmpty) {
                  bloc.add(const SelectCustomer('', '', 0));
                  return const Iterable<Map<String, dynamic>>.empty();
                }

                // If user modified the text manually, clear the current selection
                // to force them to pick an item from the list.
                if (bloc.state.customerName != textEditingValue.text) {
                  bloc.add(const SelectCustomer('', '', 0));
                }

                final repo = sl<IVisitEntryRepository>();
                final results = await repo.searchCustomers(
                  textEditingValue.text,
                );
                return results;
              },
              displayStringForOption: (Map<String, dynamic> option) {
                final name = option['name'] as String?;
                if (name != null && name.trim().isNotEmpty) {
                  return name;
                }
                return option['phone'] as String? ?? option['number'] as String? ?? 'Unknown Customer';
              },
              onSelected: (Map<String, dynamic> selection) {
                final remainingAmc = selection['remainingAmcVisits'] ?? selection['remaining_amc_visits'] ?? 0;
                
                final name = selection['name'] as String?;
                final displayName = (name != null && name.trim().isNotEmpty) 
                                      ? name 
                                      : (selection['phone'] as String? ?? selection['number'] as String? ?? 'Unknown Customer');

                context.read<VisitEntryBloc>().add(
                  SelectCustomer(
                    selection['id'] as String,
                    displayName,
                    remainingAmc as int,
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 250,
                        maxWidth: 300,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);
                          return ListTile(
                            title: Text(
                              '${option['name'] ?? 'Unknown'}${((option['phone'] ?? option['number'])?.toString().isNotEmpty == true) ? ' - ${option['phone'] ?? option['number']}' : ''}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              '${option['phone'] ?? option['number'] ?? 'No Phone'} • ${option['address'] ?? option['locality'] ?? 'No Address'}',
                              style: TextStyle(
                                color: context.colors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            onTap: () {
                              onSelected(option);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              fieldViewBuilder:
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onSubmitted: (String value) {
                        onFieldSubmitted();
                      },
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: darkPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter customer details..',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: context.colors.textTertiary,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 14, right: 10),
                          child: Icon(
                            Icons.search_rounded,
                            color: primaryColor.withOpacity(0.7),
                            size: 22,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        filled: true,
                        fillColor: context.colors.background,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: context.colors.border,
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 1.6,
                          ),
                        ),
                      ),
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}
