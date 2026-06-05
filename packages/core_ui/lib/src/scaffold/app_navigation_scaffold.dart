import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import '../theme/app_colors.dart';

class AppNavigationScaffold extends StatelessWidget {
  final Widget child;

  const AppNavigationScaffold({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/customers')) return 1;
    if (location.startsWith('/emi')) return 2;
    if (location.startsWith('/service')) return 3;
    return 0; // Default to Home ('/')
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/customers');
        break;
      case 2:
        context.go('/emi');
        break;
      case 3:
        context.go('/service');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using the custom enterprise AppColors extension we built earlier!
    final colors = context.colors;

    return Scaffold(
      extendBody: true, // Required for the crystal floating effect
      body: child,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _calculateSelectedIndex(context),
          onTap: (index) => _onItemTapped(index, context),
          indicatorColor: colors.primary,
          backgroundColor: colors.surface.withOpacity(0.85),
          selectedItemColor: colors.primary,
          unselectedItemColor: colors.textSecondary,
          splashBorderRadius: 30,
          items: [
            CrystalNavigationBarItem(
              icon: Icons.home_rounded,
              selectedColor: colors.primary,
            ),

            CrystalNavigationBarItem(
              icon: Icons.people_rounded,
              selectedColor: colors.primary,
            ),
            CrystalNavigationBarItem(
              icon: Icons.calculate_rounded,
              selectedColor: colors.primary,
            ),
            CrystalNavigationBarItem(
              icon: Icons.design_services_rounded,
              selectedColor: colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
