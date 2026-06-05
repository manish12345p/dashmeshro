import 'package:flutter/material.dart';
import '../../domain/entities/emi_dashboard_data.dart';
import 'package:core_ui/core_ui.dart';

class PaymentHealthCard extends StatelessWidget {
  final EmiDashboardData data;

  const PaymentHealthCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colors.infoBg, // Light blue background
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Health',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: data.onTimePaymentPercentage / 100,
                    strokeWidth: 12,
                    backgroundColor: Colors.white.withValues(alpha: 0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(context.colors.primaryDark),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${data.onTimePaymentPercentage.toInt()}%',
                          style: TextStyle(
                            color: context.colors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ON TIME',
                          style: TextStyle(
                            color: context.colors.textPrimary,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildStatRow(context, 'Early Payments', data.earlyPayments.toString(), false),
          SizedBox(height: 12),
          _buildStatRow(context, 'Grace Period', data.gracePeriod.toString().padLeft(2, '0'), false),
          SizedBox(height: 12),
          _buildStatRow(context, 'Defaulters', data.defaulters.toString().padLeft(2, '0'), true),
        ],
      ),
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value, bool isNegative) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.colors.textPrimary,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isNegative ? context.colors.error : context.colors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
