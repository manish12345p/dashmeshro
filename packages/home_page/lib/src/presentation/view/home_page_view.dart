import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/home_repository.dart';
import '../../domain/use_cases/get_home_data_usecase.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/new_sells_summary_card.dart';

class HomePageView extends StatelessWidget {
  final HomeBloc? bloc;
  
  const HomePageView({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc ?? (HomeBloc(
        getHomeDataUseCase: GetHomeDataUseCase(HomeRepository()),
      )..add(const HomeEvent.loadHomeData())),
      child: const Scaffold(
        body: _HomeContent(),
      ),
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
                          Icon(Icons.waves, color: Theme.of(context).primaryColor),
                          const SizedBox(width: AppPadding.p8),
                          Text(
                            AppStrings.appTitle,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppPadding.p24),

                  // Top Summary Cards
                  SummaryCard(
                    overlineText: AppStrings.revenueFlow,
                    valueText: '${data.newSells} New Sells',
                    subtitleText: AppStrings.thisWeekPerformance,
                    trailingIcon: const Icon(Icons.trending_up, color: Colors.green, size: 20),
                    trailingBackgroundColor: Colors.green.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: AppStrings.assetRental,
                    valueText: '${data.activeRentals} Active',
                    subtitleText: AppStrings.currentRentalPortfolio,
                    trailingIcon: const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                    trailingBackgroundColor: Colors.blue.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: AppStrings.serviceContracts,
                    valueText: '${data.activeAmcs} AMCs',
                    subtitleText: AppStrings.activeMaintenance,
                    trailingIcon: const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    trailingBackgroundColor: Colors.green.withOpacity(0.1),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: AppStrings.resolutionRate,
                    valueText: '${data.resolutionRatePercent}% Resolved',
                    subtitleText: '${data.pendingComplaintsCount} ${AppStrings.complaintsPending}',
                    trailingIcon: const Icon(Icons.error_outline, color: Colors.red, size: 20),
                    trailingBackgroundColor: Colors.red.withOpacity(0.1),
                    borderColor: Colors.red.withOpacity(0.5),
                  ),

                  const SizedBox(height: AppPadding.p32),

                  // Today's Service Schedule
                  SectionHeader(
                    title: AppStrings.todayServiceSchedule,
                    trailing: CustomButton(
                      label: AppStrings.viewCalendar,
                      onPressed: () => context.go('/calendar'),
                    ),
                  ),
                  const SizedBox(height: AppPadding.p16),
                  
                  // Scheduled Items
                  Text(
                    '| ${AppStrings.urgentAssignments}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...data.todaySchedules.where((s) => s.isUrgent).map((schedule) => Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p12),
                    child: ScheduleItemCard(
                      title: schedule.title,
                      subtitle: schedule.subtitle,
                      time: schedule.time,
                      accentColor: Colors.red,
                      trailingBadge: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.priority_high, size: 12, color: Colors.white),
                      ),
                    ),
                  )),

                  const SizedBox(height: AppPadding.p16),
                  Text(
                    '| ${AppStrings.amcPeriodicChecks}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...data.todaySchedules.where((s) => !s.isUrgent).map((schedule) => Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p12),
                    child: ScheduleItemCard(
                      title: schedule.title,
                      subtitle: schedule.subtitle,
                      time: schedule.time,
                      accentColor: Colors.green,
                      trailingBadge: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, size: 12, color: Colors.green),
                      ),
                    ),
                  )),

                  const SizedBox(height: AppPadding.p32),

                  // Pending Complaints
                  SectionHeader(
                    title: AppStrings.pendingComplaints,
                    subtitle: AppStrings.pendingComplaintsSubtitle,
                  ),
                  const SizedBox(height: AppPadding.p16),
                  Row(
                    children: [
                      _buildFilterChip(AppStrings.filterAll, true),
                      _buildFilterChip(AppStrings.filterUrgent, false),
                      _buildFilterChip(AppStrings.filterHigh, false),
                      _buildFilterChip(AppStrings.filterNormal, false),
                    ],
                  ),
                  const SizedBox(height: AppPadding.p16),
                  Container(
                    padding: AppPadding.all16,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                    ),
                    child: Column(
                      children: data.pendingComplaints.map((complaint) {
                        Color statusColor;
                        if (complaint.status == 'urgent') {
                          statusColor = Colors.red;
                        } else if (complaint.status == 'high') {
                          statusColor = Colors.orange;
                        } else {
                          statusColor = Colors.green;
                        }
                        return Column(
                          children: [
                            ComplaintListItem(
                              customerName: complaint.customerName,
                              customerId: complaint.customerId,
                              issueType: complaint.issueType,
                              statusColor: statusColor,
                            ),
                            if (complaint != data.pendingComplaints.last)
                              const Divider(height: 1),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: AppPadding.p32),

                  // Active AMC Focus
                  Container(
                    padding: AppPadding.all16,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              AppStrings.activeAmcFocus,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppPadding.p16),
                        ...data.amcProgresses.map((amc) => ProgressSummaryCard(
                          title: amc.companyName,
                          subtitle: amc.statusText,
                          progressValue: amc.progress,
                          progressColor: amc.isUrgent ? Colors.orange : Colors.green,
                          trackColor: Colors.grey.withOpacity(0.2),
                          trailingBadge: amc.isUrgent 
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(AppStrings.badgeRenew, style: TextStyle(color: Colors.white, fontSize: 10)),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(AppStrings.badgeOnTrack, style: TextStyle(color: Colors.black, fontSize: 10)),
                              ),
                        )),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppPadding.p32),

                  // New Sells Summary
                  NewSellsSummaryCard(
                    todaySells: data.todaySellsSummary,
                    weekSells: data.weekSellsSummary,
                    projectedGrowth: data.projectedGrowth,
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
        boxShadow: isSelected ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ] : null,
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
