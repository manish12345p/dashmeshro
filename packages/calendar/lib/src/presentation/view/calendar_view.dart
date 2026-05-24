import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/mock_schedule_item.dart';
import '../widgets/calendar_day_cell.dart';
import '../widgets/weekday_header_cell.dart';
import '../widgets/service_schedule_card.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDate = DateTime(2024, 10, 7);
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mock database of scheduled services for different days
  final Map<int, List<MockScheduleItem>> _dayServices = {
    2: [
      const MockScheduleItem(
        id: '1',
        name: 'Sunil Prasad',
        machineId: 'DM-1092-A',
        time: '09:00 AM',
        category: 'AMC',
        badgeLabel: 'AMC SERVICE',
        status: 'Confirmed',
        statusColor: Colors.green,
      ),
    ],
    4: [
      const MockScheduleItem(
        id: '2',
        name: 'Priya Sharma',
        machineId: 'DM-8812-Y',
        time: '11:30 AM',
        category: 'Rent',
        badgeLabel: 'RENT PICKUP',
        status: 'In Progress',
        statusColor: Colors.blue,
      ),
    ],
    7: [
      const MockScheduleItem(
        id: '3',
        name: 'Rajesh Kumar',
        machineId: 'DM-4092-X',
        time: '10:30 AM',
        category: 'AMC',
        badgeLabel: 'AMC SERVICE',
        status: 'Confirmed',
        statusColor: Colors.green,
      ),
      const MockScheduleItem(
        id: '4',
        name: 'Anita Sharma',
        machineId: 'DM-1122-Z',
        time: '02:15 PM',
        category: 'Repair',
        badgeLabel: 'REPAIR',
        status: 'Pending',
        statusColor: Colors.orange,
      ),
      const MockScheduleItem(
        id: '5',
        name: 'Vikram Singh',
        machineId: 'DM-9901-K',
        time: '04:45 PM',
        category: 'Rent',
        badgeLabel: 'RENT PICKUP',
        status: 'In Progress',
        statusColor: Colors.blue,
      ),
    ],
    9: [
      const MockScheduleItem(
        id: '6',
        name: 'Rohan Mehta',
        machineId: 'DM-7732-X',
        time: '10:00 AM',
        category: 'AMC',
        badgeLabel: 'AMC SERVICE',
        status: 'Confirmed',
        statusColor: Colors.green,
      ),
    ],
    11: [
      const MockScheduleItem(
        id: '7',
        name: 'Kiran Pal',
        machineId: 'DM-5541-M',
        time: '03:00 PM',
        category: 'Rent',
        badgeLabel: 'RENT PICKUP',
        status: 'Pending',
        statusColor: Colors.orange,
      ),
    ],
  };

  void _nextMonth() {
    setState(() {
      int nextMonth = _selectedDate.month == 12 ? 1 : _selectedDate.month + 1;
      int nextYear = _selectedDate.month == 12 ? _selectedDate.year + 1 : _selectedDate.year;
      _selectedDate = DateTime(nextYear, nextMonth, 1);
    });
  }

  void _previousMonth() {
    setState(() {
      int prevMonth = _selectedDate.month == 1 ? 12 : _selectedDate.month - 1;
      int prevYear = _selectedDate.month == 1 ? _selectedDate.year - 1 : _selectedDate.year;
      _selectedDate = DateTime(prevYear, prevMonth, 1);
    });
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeDay = _selectedDate.day;
    final currentServices = _dayServices[activeDay] ?? [];
    
    // Filter list based on selected category chip & search query
    final filteredServices = currentServices.where((item) {
      final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.machineId.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00569E),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppPadding.p12),
                
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
                        const SizedBox(width: AppPadding.p4),
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
                
                const SizedBox(height: AppPadding.p16),
                
                // Service Schedule Title & Month Switcher
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Service\nSchedule',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003366),
                        height: 1.15,
                      ),
                    ),
                    
                    // Month Navigator Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, size: 20, color: Colors.black87),
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(8),
                            onPressed: _previousMonth,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right, size: 20, color: Colors.black87),
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(8),
                            onPressed: _nextMonth,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppPadding.p20),
                
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search services by name or machine ID...',
                      hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
                      prefixIcon: Icon(Icons.search, color: Colors.black38),
                      suffixIcon: Icon(Icons.tune, color: Colors.black38),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                
                const SizedBox(height: AppPadding.p16),
                
                // Horizontal category chips
                Row(
                  children: [
                    _buildCategoryChip('All'),
                    _buildCategoryChip('AMC'),
                    _buildCategoryChip('Rent'),
                    _buildCategoryChip('Repair'),
                  ],
                ),
                
                const SizedBox(height: AppPadding.p20),
                
                // Calendar Days Grid Card
                Container(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Weekdays Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          WeekdayHeaderCell(text: 'MON'),
                          WeekdayHeaderCell(text: 'TUE'),
                          WeekdayHeaderCell(text: 'WED'),
                          WeekdayHeaderCell(text: 'THU'),
                          WeekdayHeaderCell(text: 'FRI'),
                          WeekdayHeaderCell(text: 'SAT'),
                          WeekdayHeaderCell(text: 'SUN'),
                        ],
                      ),
                      const SizedBox(height: AppPadding.p16),
                      
                      // Week 1 Grid Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CalendarDayCell(dayNumber: 30, isGreyedOut: true),
                          CalendarDayCell(
                            dayNumber: 1,
                            isSelected: activeDay == 1,
                            onTap: () => _selectDay(1),
                          ),
                          CalendarDayCell(
                            dayNumber: 2,
                            isSelected: activeDay == 2,
                            hasAmcDot: true,
                            onTap: () => _selectDay(2),
                          ),
                          CalendarDayCell(
                            dayNumber: 3,
                            isSelected: activeDay == 3,
                            onTap: () => _selectDay(3),
                          ),
                          CalendarDayCell(
                            dayNumber: 4,
                            isSelected: activeDay == 4,
                            hasRentDot: true,
                            onTap: () => _selectDay(4),
                          ),
                          CalendarDayCell(
                            dayNumber: 5,
                            isSelected: activeDay == 5,
                            onTap: () => _selectDay(5),
                          ),
                          CalendarDayCell(
                            dayNumber: 6,
                            isSelected: activeDay == 6,
                            onTap: () => _selectDay(6),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppPadding.p12),
                      
                      // Week 2 Grid Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CalendarDayCell(
                            dayNumber: 7,
                            isSelected: activeDay == 7,
                            hasAmcDot: true, // It is selected but also has AMC items
                            onTap: () => _selectDay(7),
                          ),
                          CalendarDayCell(
                            dayNumber: 8,
                            isSelected: activeDay == 8,
                            onTap: () => _selectDay(8),
                          ),
                          CalendarDayCell(
                            dayNumber: 9,
                            isSelected: activeDay == 9,
                            hasAmcDot: true,
                            onTap: () => _selectDay(9),
                          ),
                          CalendarDayCell(
                            dayNumber: 10,
                            isSelected: activeDay == 10,
                            onTap: () => _selectDay(10),
                          ),
                          CalendarDayCell(
                            dayNumber: 11,
                            isSelected: activeDay == 11,
                            hasRentDot: true,
                            onTap: () => _selectDay(11),
                          ),
                          CalendarDayCell(
                            dayNumber: 12,
                            isSelected: activeDay == 12,
                            onTap: () => _selectDay(12),
                          ),
                          CalendarDayCell(
                            dayNumber: 13,
                            isSelected: activeDay == 13,
                            onTap: () => _selectDay(13),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: AppPadding.p16),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: AppPadding.p12),
                      
                      // Legends Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildLegendItem(const Color(0xFF00569E), 'AMC'),
                          const SizedBox(width: AppPadding.p16),
                          _buildLegendItem(const Color(0xFF27AE60), 'Rent'),
                          const SizedBox(width: AppPadding.p16),
                          _buildLegendItem(const Color(0xFFE2B93B), 'Repair'),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppPadding.p24),
                
                // Scheduled Services Title Area
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text(
                          'Scheduled Services',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Today, Oct $activeDay',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Color(0xFF00569E),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppPadding.p12),
                
                // Services List
                if (filteredServices.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.event_busy, size: 48, color: Colors.grey.shade300),
                          const SizedBox(height: 8),
                          Text(
                            'No services scheduled for this day.',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: filteredServices.map((item) {
                      return ServiceScheduleCard(item: item);
                    }).toList(),
                  ),
                  
                const SizedBox(height: 100), // Bottom padding for bottom navigation bar
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectDay(int day) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, day);
    });
  }

  Widget _buildCategoryChip(String label) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00569E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.15),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00569E).withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
