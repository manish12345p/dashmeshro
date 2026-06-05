import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/home_repository.dart';
import '../../domain/use_cases/get_home_data_usecase.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/visit_schedule_card.dart';
import '../widgets/visit_search_delegate.dart';
import '../widgets/notification_dialog.dart';
import '../widgets/expense_dialogs.dart';

class HomePageView extends StatelessWidget {
  final HomeBloc? bloc;

  const HomePageView({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:
          bloc ??
          (HomeBloc(getHomeDataUseCase: GetHomeDataUseCase(HomeRepository()))
            ..add(const HomeEvent.loadHomeData())),
      child: const Scaffold(
        body: _HomeContent(),
        floatingActionButton: _ExpenseFab(),
      ),
    );
  }
}

class _ExpenseFab extends StatelessWidget {
  const _ExpenseFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => AddExpenseDialog.show(context),
      backgroundColor: const Color(0xFF003366),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false, // Don't add padding for bottom bar here
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is HomeLoaded) {
            final data = state.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p48 + 80, // Extra padding for bottom nav
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar Area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => ViewExpensesDialog.show(context),
                            child: Icon(
                              Icons.waves,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: AppPadding.p8),
                          Text(
                            AppStrings.appTitle,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.1,
                                  height: 1.1,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: VisitSearchDelegate(),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onPressed: () => NotificationDialog.show(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppPadding.p24),

                  // Top Summary Cards
                  SummaryCard(
                    overlineText: 'Total Visits',
                    valueText: '${data.totalServices}',
                    subtitleText: 'Overall visits',
                    trailingIcon: const Icon(
                      Icons.trending_up,
                      color: Colors.green,
                      size: 20,
                    ),
                    trailingBackgroundColor: Colors.green.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: 'New RO',
                    valueText: '${data.newRoServices}',
                    subtitleText: 'Newly installed ROs',
                    trailingIcon: const Icon(
                      Icons.water_drop,
                      color: Colors.blue,
                      size: 20,
                    ),
                    trailingBackgroundColor: Colors.blue.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: 'Total AMC',
                    valueText: '${data.amcServices}',
                    subtitleText: 'AMC visits performed',
                    trailingIcon: const Icon(
                      Icons.verified_user,
                      color: Colors.green,
                      size: 20,
                    ),
                    trailingBackgroundColor: Colors.green.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: 'Service & Repair',
                    valueText: '${data.repairServices}',
                    subtitleText: 'Combined service and repair',
                    trailingIcon: const Icon(
                      Icons.build,
                      color: Colors.orange,
                      size: 20,
                    ),
                    trailingBackgroundColor: Colors.orange.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p32),

                  // Today's Service Schedule
                  SectionHeader(
                    title: 'Total Visit Schedule',
                    trailing: TextButton(
                      onPressed: () => context.go('/calendar'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'View Calendar',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppPadding.p16),

                  // List of today's visit schedules
                  if (data.todayNotifications.isNotEmpty)
                    ...data.todayNotifications.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: VisitScheduleCard(item: item),
                      ),
                    ),
                  if (data.todayNotifications.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          'No visits scheduled for today',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  const SizedBox(height: AppPadding.p32),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.3),
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.grey.shade600,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}
