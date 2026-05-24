import 'package:flutter/material.dart';
import '../widgets/customer_selector.dart';
import '../widgets/service_type_selector.dart';
import '../widgets/remarks_date_selector.dart';

class ServiceEntryView extends StatefulWidget {
  const ServiceEntryView({super.key});

  @override
  State<ServiceEntryView> createState() => _ServiceEntryViewState();
}

class _ServiceEntryViewState extends State<ServiceEntryView> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  
  String _selectedType = 'COMPLAIN'; // Default matching screenshot
  bool _isUrgent = true;            // Default matching screenshot (Urgent: Yes)
  DateTime? _selectedDate;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _onRecentChipTapped(String label) {
    // Strip prefix if necessary, e.g. "RECENT: RAHUL SHARMA" -> "RAHUL SHARMA"
    final cleanLabel = label.startsWith('RECENT: ') ? label.replaceFirst('RECENT: ', '') : label;
    setState(() {
      _searchController.text = cleanLabel;
      _searchQuery = cleanLabel;
    });
  }

  void _onTypeSelected(String type) {
    setState(() {
      _selectedType = type;
    });
  }

  void _onUrgencyChanged(bool urgent) {
    setState(() {
      _isUrgent = urgent;
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _commitEntry() {
    // Validate first
    if (_searchQuery.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please identify a customer.')),
      );
      return;
    }
    
    // Perform commit logic (e.g. print values, clear form)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Committed $_selectedType entry for $_searchQuery! (Urgent: ${_isUrgent ? "Yes" : "No"})',
        ),
      ),
    );

    // Optional: Clear form
    setState(() {
      _searchController.clear();
      _remarksController.clear();
      _searchQuery = '';
      _selectedDate = null;
      _selectedType = 'COMPLAIN';
      _isUrgent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                
                // Top Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.black87),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Dashmesh Mechanix',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150',
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Main Header Titles
                const Text(
                  'New Service Entry',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Log a new interaction or service request.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Section 1: Identify Customer
                CustomerSelector(
                  searchController: _searchController,
                  onSearchChanged: _onSearchChanged,
                  onRecentChipTapped: _onRecentChipTapped,
                ),
                
                const SizedBox(height: 16),
                
                // Section 2: Define Service Type
                ServiceTypeSelector(
                  selectedType: _selectedType,
                  onTypeSelected: _onTypeSelected,
                  isUrgent: _isUrgent,
                  onUrgencyChanged: _onUrgencyChanged,
                ),
                
                const SizedBox(height: 16),
                
                // Section 3: Remarks & Date
                RemarksDateSelector(
                  selectedDate: _selectedDate,
                  onDateSelected: _onDateSelected,
                  remarksController: _remarksController,
                ),
                
                const SizedBox(height: 24),
                
                // Commit Entry Button
                GestureDetector(
                  onTap: _commitEntry,
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFF004A85), // Commit button dark blue
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF004A85).withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Commit Entry',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 120), // Padding to avoid overlap with bottom navigation bar
              ],
            ),
          ),
        ),
      ),
    );
  }
}
