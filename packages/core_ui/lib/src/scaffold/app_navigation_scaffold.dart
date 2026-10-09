import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:core/core.dart'; // import app_role
import 'package:flutter_bloc/flutter_bloc.dart'; // import bloc
import '../theme/app_colors.dart';

class AppNavigationScaffold extends StatelessWidget {
  final Widget child;

  const AppNavigationScaffold({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context, bool isAdmin) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/customers')) return 1;
    if (isAdmin && location.startsWith('/emi')) return 2;
    if (location.startsWith('/service')) return isAdmin ? 3 : 2;
    if (location.startsWith('/history')) return isAdmin ? 4 : 3;
    return 0; // Default to Home ('/')
  }

  void _onItemTapped(int index, BuildContext context, bool isAdmin) {
    if (index == 0) {
      context.go('/');
    } else if (index == 1) {
      context.go('/customers');
    } else if (isAdmin && index == 2) {
      context.go('/emi');
    } else if ((isAdmin && index == 3) || (!isAdmin && index == 2)) {
      context.go('/service');
    } else if ((isAdmin && index == 4) || (!isAdmin && index == 3)) {
      context.go('/history');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using the custom enterprise AppColors extension we built earlier!
    final colors = context.colors;

    return BlocBuilder<RoleCubit, AppRole>(
      builder: (context, role) {
        final isAdmin = role == AppRole.admin;

        return Scaffold(
          extendBody: true, // Required for the crystal floating effect
          body: child,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: CrystalNavigationBar(
              currentIndex: _calculateSelectedIndex(context, isAdmin),
              onTap: (index) => _onItemTapped(index, context, isAdmin),
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
                  icon: Icons.person_add_rounded,
                  selectedColor: colors.primary,
                ),
                if (isAdmin)
                  CrystalNavigationBarItem(
                    icon: Icons.calculate_rounded,
                    selectedColor: colors.primary,
                  ),
                CrystalNavigationBarItem(
                  icon: Icons.design_services_rounded,
                  selectedColor: colors.primary,
                ),
                CrystalNavigationBarItem(
                  icon: Icons.history_rounded,
                  selectedColor: colors.primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
