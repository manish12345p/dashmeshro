import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    Color accentColor;

    final roTypeLower = customer.roType.toLowerCase();
    if (roTypeLower.contains('undersink')) {
      accentColor = Colors.purple;
    } else if (roTypeLower.contains('kent')) {
      accentColor = Colors.blue;
    } else if (roTypeLower.contains('grand')) {
      accentColor = Colors.green;
    } else if (roTypeLower.contains('pureit')) {
      accentColor = Colors.orange;
    } else if (roTypeLower.contains('swift')) {
      accentColor = Colors.teal;
    } else if (roTypeLower.contains('aquaguard')) {
      accentColor = Colors.indigo;
    } else if (roTypeLower.contains('dolphin')) {
      accentColor = Colors.cyan;
    } else {
      accentColor = Colors.grey.shade600;
    }

    return Container(
      margin: EdgeInsets.only(bottom: AppPadding.p16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border(left: BorderSide(color: accentColor, width: 5)),
        boxShadow: [
          BoxShadow(
            color: context.colors.textSecondary.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Name and RO Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    customer.number.isNotEmpty ? '${customer.name} - ${customer.number}' : customer.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (customer.roType.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      customer.roType.toUpperCase(),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12),

            // Phone Number
            if (customer.number.isNotEmpty)
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 16,
                    color: context.colors.textSecondary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    customer.number,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

            if (customer.number.isNotEmpty && customer.address.isNotEmpty)
              SizedBox(height: 8),

            // Address
            if (customer.address.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: context.colors.textSecondary,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      customer.address,
                      style: TextStyle(
                        fontSize: 13,
                        color: context.colors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),

            SizedBox(height: 16),

            // View Details Button Row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/customers/${customer.id}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.primaryDark,
                      foregroundColor: context.colors.surface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
