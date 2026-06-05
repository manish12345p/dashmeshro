import 'package:flutter/material.dart';
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
import '../widgets/calendar_visit_card.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    // Load today's month data on calendar open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarBloc>().add(
        CalendarEvent.loadMonth(_selectedDate.year, _selectedDate.month),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,

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
              if (item.date.year == _selectedDate.year &&
                  item.date.month == _selectedDate.month) {
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
                              icon: Icon(
                                Icons.arrow_back,
                                color: context.colors.textPrimary,
                              ),
                              onPressed: () {
                                if (context.canPop()) {
                                  context.pop();
                                } else {
                                  context.go('/');
                                }
                              },
                            ),
                            const SizedBox(width: AppPadding.p4),
                            Text(
                              'Dashmesh Mechanix',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: context.colors.textPrimary,
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
                        Text(
                          'Service\nSchedule',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: context.colors.primaryDark,
                            height: 1.15,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: context.colors.textSecondary.withValues(
                                  alpha: 0.05,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => _changeMonth(-1, context),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: context.colors.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.colors.primaryDark,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => _changeMonth(1, context),
                                child: Icon(
                                  Icons.chevron_right,
                                  color: context.colors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppPadding.p24),

                    // Dynamic Calendar UI - swipe to change month
                    GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity != null) {
                          if (details.primaryVelocity! < -100) {
                            // Swipe left → next month
                            _changeMonth(1, context);
                          } else if (details.primaryVelocity! > 100) {
                            // Swipe right → previous month
                            _changeMonth(-1, context);
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          color: context.colors.surface,
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusLarge,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.colors.textSecondary.withValues(
                                alpha: 0.03,
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Weekdays Header
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeekdayHeaderCell(text: 'M'),
                                WeekdayHeaderCell(text: 'T'),
                                WeekdayHeaderCell(text: 'W'),
                                WeekdayHeaderCell(text: 'T'),
                                WeekdayHeaderCell(text: 'F'),
                                WeekdayHeaderCell(text: 'S'),
                                WeekdayHeaderCell(text: 'S'),
                              ],
                            ),
                            const SizedBox(height: AppPadding.p12),
                            Divider(height: 1, color: context.colors.border),
                            const SizedBox(height: AppPadding.p12),

                            // Grid Builder
                            _buildCalendarGrid(daysWithEvents),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppPadding.p24),

                    // Scheduled Services Title Area
                    Text(
                      'Scheduled Visits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.colors.primaryDark,
                      ),
                    ),

                    const SizedBox(height: AppPadding.p12),

                    // Services List
                    if (state.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (filteredServices.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p24,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.event_busy,
                                size: 48,
                                color: context.colors.textTertiary,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppStrings.noVisitsScheduled,
                                style: TextStyle(
                                  color: context.colors.textSecondary,
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
                            child: CalendarVisitCard(item: item),
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
    final firstDayOfMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      1,
    );
    final daysInMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month + 1,
      0,
    ).day;
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
        gridRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: currentRow,
          ),
        );
        gridRows.add(const SizedBox(height: AppPadding.p12));
        currentRow = [];
      }
    }

    if (currentRow.isNotEmpty) {
      // Pad the last row
      while (currentRow.length < 7) {
        currentRow.add(const SizedBox(width: 32, height: 48));
      }
      gridRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: currentRow,
        ),
      );
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
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + increment,
        1,
      );
    });
    context.read<CalendarBloc>().add(
      CalendarEvent.loadMonth(_selectedDate.year, _selectedDate.month),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
