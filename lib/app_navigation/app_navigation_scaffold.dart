import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationScaffold extends StatelessWidget {
  final Widget child;

  const AppNavigationScaffold({
    super.key,
    required this.child,
  });

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/customers')) return 1;
    if (location.startsWith('/service')) return 2;
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
        context.go('/service');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade100,
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                index: 0,
                unselectedIcon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                label: 'HOME',
                selectedIndex: selectedIndex,
              ),
              _buildNavItem(
                context: context,
                index: 1,
                unselectedIcon: Icons.people_outline_rounded,
                selectedIcon: Icons.people_rounded,
                label: 'CLIENTS',
                selectedIndex: selectedIndex,
              ),
              _buildNavItem(
                context: context,
                index: 2,
                unselectedIcon: Icons.note_add_outlined,
                selectedIcon: Icons.edit_note_rounded,
                label: 'ENTRY',
                selectedIndex: selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData unselectedIcon,
    required IconData selectedIcon,
    required String label,
    required int selectedIndex,
  }) {
    final isSelected = selectedIndex == index;

    if (isSelected) {
      // Light blue pill capsule background and dark blue text/icon
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFDCEAF5), // Faded blue background
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(selectedIcon, color: const Color(0xFF003865), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF003865),
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => _onItemTapped(index, context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(unselectedIcon, color: Colors.grey.shade400, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
