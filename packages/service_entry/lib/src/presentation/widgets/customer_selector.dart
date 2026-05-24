import 'package:flutter/material.dart';

class CustomerSelector extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onRecentChipTapped;

  const CustomerSelector({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onRecentChipTapped,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFF004A85), // Dark blue circle
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
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
                    'Identify Customer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.person_search_outlined,
                color: Colors.grey.shade300,
                size: 32,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Search Input Field
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search by name, phone or vehicle...',
                hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
                prefixIcon: Icon(Icons.search, color: Colors.black38, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Recent Chips Row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildRecentChip('RECENT: RAHUL SHARMA'),
              _buildRecentChip('AMAN SINGH'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChip(String label) {
    return GestureDetector(
      onTap: () => onRecentChipTapped(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF2F8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF335C80),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
