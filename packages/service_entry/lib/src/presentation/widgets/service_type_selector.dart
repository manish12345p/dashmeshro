import 'package:flutter/material.dart';

class ServiceTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeSelected;
  final bool isUrgent;
  final ValueChanged<bool> onUrgencyChanged;

  const ServiceTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
    required this.isUrgent,
    required this.onUrgencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF004A85),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Define Service Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Grid of 4 Service Types
          Row(
            children: [
              Expanded(
                child: _buildTypeCard(
                  type: 'SELL',
                  label: 'SELL',
                  icon: Icons.shopping_cart_outlined,
                  activeBgColor: const Color(0xFFEFF6FF),
                  activeTextColor: const Color(0xFF1D4ED8),
                  activeBorderColor: const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTypeCard(
                  type: 'RENT',
                  label: 'RENT',
                  icon: Icons.vpn_key_outlined,
                  activeBgColor: const Color(0xFFEEF2F6),
                  activeTextColor: const Color(0xFF334155),
                  activeBorderColor: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildAMCCard(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildComplainCard(),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 16),
          
          // Urgency Section
          const Text(
            'IS THIS URGENT?',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
              letterSpacing: 0.5,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildUrgentButton(label: 'Yes', value: true),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildUrgentButton(label: 'No', value: false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard({
    required String type,
    required String label,
    required IconData icon,
    required Color activeBgColor,
    required Color activeTextColor,
    required Color activeBorderColor,
  }) {
    final isSelected = selectedType == type;

    return GestureDetector(
      onTap: () => onTypeSelected(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 72,
        decoration: BoxDecoration(
          color: isSelected ? activeBgColor : const Color(0xFFEFF4F9),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: activeBorderColor, width: 1.5)
              : Border.all(color: Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? activeTextColor : Colors.black87,
              size: 22,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? activeTextColor : Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAMCCard() {
    final isSelected = selectedType == 'AMC';

    return GestureDetector(
      onTap: () => onTypeSelected('AMC'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 72,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F8F0) : const Color(0xFFEFF4F9),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? const Border(
                  left: BorderSide(color: Color(0xFF27AE60), width: 4),
                  top: BorderSide(color: Color(0xFF27AE60), width: 0.5),
                  right: BorderSide(color: Color(0xFF27AE60), width: 0.5),
                  bottom: BorderSide(color: Color(0xFF27AE60), width: 0.5),
                )
              : Border.all(color: Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_rounded,
              color: isSelected ? const Color(0xFF27AE60) : Colors.black87,
              size: 22,
            ),
            const SizedBox(height: 6),
            Text(
              'AMC',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF27AE60) : Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplainCard() {
    final isSelected = selectedType == 'COMPLAIN';

    return GestureDetector(
      onTap: () => onTypeSelected('COMPLAIN'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 72,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEADBC8) : const Color(0xFFEFF4F9),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFF6B4F3E), width: 2)
              : Border.all(color: Colors.transparent),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              color: isSelected ? const Color(0xFF6B4F3E) : Colors.black87,
              size: 22,
            ),
            const SizedBox(height: 6),
            Text(
              'COMPLAIN',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF6B4F3E) : Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUrgentButton({required String label, required bool value}) {
    final isActive = isUrgent == value;

    return GestureDetector(
      onTap: () => onUrgencyChanged(value),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF003865) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF003865).withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
