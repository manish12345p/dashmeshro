# -*- coding: utf-8 -*-
import io

new_content = """import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/schedule_item.dart';
import '../bloc/calendar_bloc.dart';
import '../bloc/calendar_event.dart';
import '../bloc/calendar_state.dart';
import '../widgets/calendar_day_cell.dart';
import '../widgets/weekday_header_cell.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00569E),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            final activeDay = _selectedDate.day;
            
            // Get current month's items
            final currentMonthItems = state.currentMonthSchedules;
            
            // Filter list based on selected day
            final filteredServices = currentMonthItems.where((item) {
              return item.date.year == _selectedDate.year &&
                     item.date.month == _selectedDate.month &&
                     item.date.day == activeDay;
            }).toList();
            
            // Map dates to events for dots
            final daysWithEvents = <int>{};
            for (var item in currentMonthItems) {
              if (item.date.year == _selectedDate.year && item.date.month == _selectedDate.month) {
                daysWithEvents.add(item.date.day);
              }
            }

            return SingleChildScrollView(
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
                              icon: const Icon(Icons.arrow_back, color: Colors.black87),
                              onPressed: () => context.pop(),
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
                      ],
                    ),
                    
                    const SizedBox(height: AppPadding.p16),
                    
                    // Service Schedule Title & Month Switcher
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Service\\nSchedule',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                            height: 1.15,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => _changeMonth(-1, context),
                                child: const Icon(Icons.chevron_left, color: Color(0xFF00569E)),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF003366),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => _changeMonth(1, context),
                                child: const Icon(Icons.chevron_right, color: Color(0xFF00569E)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppPadding.p24),
                    
                    // Dynamic Calendar UI
                    Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          // Weekdays Header
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeekdayHeaderCell(day: 'M'),
                              WeekdayHeaderCell(day: 'T'),
                              WeekdayHeaderCell(day: 'W'),
                              WeekdayHeaderCell(day: 'T'),
                              WeekdayHeaderCell(day: 'F'),
                              WeekdayHeaderCell(day: 'S'),
                              WeekdayHeaderCell(day: 'S'),
                            ],
                          ),
                          const SizedBox(height: AppPadding.p12),
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          const SizedBox(height: AppPadding.p12),
                          
                          // Grid Builder
                          _buildCalendarGrid(daysWithEvents),
                          
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: AppPadding.p24),
                    
                    // Scheduled Services Title Area
                    const Text(
                      'Scheduled Visits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003366),
                      ),
                    ),
                    
                    const SizedBox(height: AppPadding.p12),
                    
                    // Services List
                    if (state.isLoading)
                      const Center(child: Padding(padding: EdgeInsets.all(24.0), child: CircularProgressIndicator()))
                    else if (filteredServices.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.event_busy, size: 48, color: Colors.grey.shade300),
                              const SizedBox(height: 8),
                              Text(
                                'No visits scheduled for this day.',
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
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ScheduleItemCard(
                              title: item.name,
                              subtitle: '${item.category} - ${item.machineId}\\n${item.phone}',
                              time: DateFormat('hh:mm a').format(item.date),
                              accentColor: item.statusColor,
                              hasWhatsApp: true,
                              hasView: true,
                              onViewPressed: () {},
                              onWhatsAppPressed: () {},
                            ),
                          );
                        }).toList(),
                      ),
                      
                    const SizedBox(height: 100), // Bottom padding
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildCalendarGrid(Set<int> daysWithEvents) {
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    // Monday is 1, Sunday is 7. We want M,T,W,T,F,S,S.
    final firstWeekday = firstDayOfMonth.weekday; 
    
    final List<Widget> gridRows = [];
    List<Widget> currentRow = [];
    
    // Add empty cells for days before the 1st
    for (int i = 1; i < firstWeekday; i++) {
      currentRow.add(const SizedBox(width: 32, height: 48));
    }
    
    for (int day = 1; day <= daysInMonth; day++) {
      currentRow.add(
        CalendarDayCell(
          dayNumber: day,
          isSelected: _selectedDate.day == day,
          hasAmcDot: daysWithEvents.contains(day),
          onTap: () => _selectDay(day),
        ),
      );
      
      if (currentRow.length == 7) {
        gridRows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: currentRow));
        gridRows.add(const SizedBox(height: AppPadding.p12));
        currentRow = [];
      }
    }
    
    if (currentRow.isNotEmpty) {
      // Pad the last row
      while (currentRow.length < 7) {
        currentRow.add(const SizedBox(width: 32, height: 48));
      }
      gridRows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: currentRow));
    }
    
    return Column(children: gridRows);
  }

  void _selectDay(int day) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, day);
    });
  }
  
  void _changeMonth(int increment, BuildContext context) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + increment, 1);
    });
    context.read<CalendarBloc>().add(LoadMonth(year: _selectedDate.year, month: _selectedDate.month));
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
"""

with io.open(r'packages/calendar/lib/src/presentation/view/calendar_view.dart', 'w', encoding='utf-8') as f:
    f.write(new_content)
