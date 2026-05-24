import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class NewSellsSummaryCard extends StatelessWidget {
  final int todaySells;
  final int weekSells;
  final String projectedGrowth;

  const NewSellsSummaryCard({
    super.key,
    required this.todaySells,
    required this.weekSells,
    required this.projectedGrowth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: AppPadding.all24,
      decoration: BoxDecoration(
        color: const Color(0xFF0F3E61), // Dark blue background as per design
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.newSellsSummary,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: AppPadding.p24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.today,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
              Text(
                '$todaySells ${AppStrings.units}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Padding(
            padding: AppPadding.vertical8,
            child: Divider(color: Colors.white24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.thisWeek,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
              Text(
                '$weekSells ${AppStrings.units}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Padding(
            padding: AppPadding.vertical8,
            child: Divider(color: Colors.white24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.projectedGrowth,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
              Text(
                projectedGrowth,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF4ADE80), // Light green for growth
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
