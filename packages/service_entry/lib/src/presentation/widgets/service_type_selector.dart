import 'package:flutter/material.dart';

class ServiceTypeSelectorWidget extends StatefulWidget {
  const ServiceTypeSelectorWidget({super.key});

  @override
  State<ServiceTypeSelectorWidget> createState() =>
      _ServiceTypeSelectorWidgetState();
}

class _ServiceTypeSelectorWidgetState extends State<ServiceTypeSelectorWidget> {
  static const Color _primaryColor = Color(0xFF2F80ED);
  static const Color _urgentActiveColor = Color(0xFFEB5757);

  int _selectedTypeIndex = 0;
  bool _isUrgent = false;

  static const List<_ServiceTypeOption> _serviceTypes = [
    _ServiceTypeOption(label: 'Sell', icon: Icons.sell_rounded),
    _ServiceTypeOption(label: 'Rent', icon: Icons.vpn_key_rounded),
    _ServiceTypeOption(label: 'AMC', icon: Icons.verified_user_rounded),
    _ServiceTypeOption(label: 'Complain', icon: Icons.report_problem_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildServiceTypeGrid(),
            const SizedBox(height: 24),
            _buildUrgencySection(),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.build_circle_rounded,
            color: _primaryColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          '2. Define Service Type',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  // ── Service Type Grid ───────────────────────────────────────────────────

  Widget _buildServiceTypeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _serviceTypes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        final option = _serviceTypes[index];
        final isSelected = _selectedTypeIndex == index;
        return _ServiceTypeChip(
          label: option.label,
          icon: option.icon,
          isSelected: isSelected,
          primaryColor: _primaryColor,
          onTap: () => setState(() => _selectedTypeIndex = index),
        );
      },
    );
  }

  // ── Urgency Section ─────────────────────────────────────────────────────

  Widget _buildUrgencySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.priority_high_rounded,
                size: 18, color: Color(0xFF828282)),
            const SizedBox(width: 6),
            const Text(
              'Is this urgent?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Service/Mechanic dispatch required',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF828282),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _UrgencyToggleButton(
              label: 'No',
              isActive: !_isUrgent,
              activeColor: _urgentActiveColor,
              onTap: () => setState(() => _isUrgent = false),
            ),
            const SizedBox(width: 10),
            _UrgencyToggleButton(
              label: 'Yes',
              isActive: _isUrgent,
              activeColor: _primaryColor,
              onTap: () => setState(() => _isUrgent = true),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Data Model ──────────────────────────────────────────────────────────────

class _ServiceTypeOption {
  final String label;
  final IconData icon;

  const _ServiceTypeOption({required this.label, required this.icon});
}

// ── Service Type Chip ───────────────────────────────────────────────────────

class _ServiceTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color primaryColor;
  final VoidCallback onTap;

  const _ServiceTypeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? primaryColor : const Color(0xFFF5F6FA),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? primaryColor
                  : const Color(0xFFE0E0E0),
              width: 1.2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : const Color(0xFF4F4F4F),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF333333),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Urgency Toggle Button ───────────────────────────────────────────────────

class _UrgencyToggleButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _UrgencyToggleButton({
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? activeColor : const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? activeColor : const Color(0xFFE0E0E0),
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF4F4F4F),
          ),
        ),
      ),
    );
  }
}
