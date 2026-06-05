import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:core/core.dart';

import '../../data/repositories/home_repository.dart';
import '../../domain/use_cases/get_home_data_usecase.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/visit_schedule_card.dart';
import '../widgets/visit_search_delegate.dart';
import '../widgets/notification_dialog.dart';
import '../widgets/expense_dialogs.dart';
import '../widgets/manage_ro_types_dialog.dart';

class HomePageView extends StatelessWidget {
  final HomeBloc? bloc;

  const HomePageView({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:
          bloc ?? (sl<HomeBloc>()..add(const HomeEvent.loadHomeData())),
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
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 80.0,
      ), // Offset to avoid overlapping with bottom nav bar
      child: FloatingActionButton(
        onPressed: () => AddExpenseDialog.show(context),
        backgroundColor: const Color(0xFF003366),
        child: const Icon(Icons.add, color: Colors.white),
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
                          GestureDetector(
                            onTap: () => ViewExpensesDialog.show(context),
                            child: Icon(
                              Icons.edit_document,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: AppPadding.p8),
                          const _AdminUnlockTitle(),
                          const SizedBox(width: AppPadding.p4),
                          BlocBuilder<ThemeCubit, ThemeMode>(
                            builder: (context, themeMode) {
                              final isDark =
                                  themeMode == ThemeMode.dark ||
                                  (themeMode == ThemeMode.system &&
                                      Theme.of(context).brightness ==
                                          Brightness.dark);
                              return GestureDetector(
                                onTap: () =>
                                    context.read<ThemeCubit>().toggleTheme(),
                                child: Icon(
                                  isDark ? Icons.light_mode : Icons.dark_mode,
                                  color: isDark ? Colors.white : Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                              );
                            },
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
                            icon: const Icon(Icons.settings_outlined),
                            onPressed: () => ManageRoTypesDialog.show(context),
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
                    overlineText: AppStrings.totalVisits,
                    valueText: '${data.totalServices}',
                    subtitleText: AppStrings.totalVisitsSubtitle,
                    trailingIcon: Icon(
                      Icons.trending_up,
                      color: context.colors.success,
                      size: 20,
                    ),
                    trailingBackgroundColor: context.colors.successBg,
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: AppStrings.newRo,
                    valueText: '${data.newRoServices}',
                    subtitleText: AppStrings.newRoSubtitle,
                    trailingIcon: Icon(
                      Icons.water_drop,
                      color: context.colors.primary,
                      size: 20,
                    ),
                    trailingBackgroundColor: context.colors.primary.withValues(
                      alpha: 0.1,
                    ),
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: AppStrings.totalAmc,
                    valueText: '${data.amcServices}',
                    subtitleText: AppStrings.totalAmcSubtitle,
                    trailingIcon: Icon(
                      Icons.verified_user,
                      color: context.colors.success,
                      size: 20,
                    ),
                    trailingBackgroundColor: context.colors.successBg,
                  ),
                  const SizedBox(height: AppPadding.p12),
                  SummaryCard(
                    overlineText: AppStrings.serviceAndRepair,
                    valueText: '${data.repairServices}',
                    subtitleText: AppStrings.serviceAndRepairSubtitle,
                    trailingIcon: Icon(
                      Icons.build,
                      color: context.colors.warning,
                      size: 20,
                    ),
                    trailingBackgroundColor: context.colors.warningBg,
                  ),
                  const SizedBox(height: AppPadding.p32),

                  // Today's Service Schedule
                  SectionHeader(
                    title: AppStrings.totalVisitSchedule,
                    trailing: TextButton(
                      onPressed: () => context.go('/calendar'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        AppStrings.viewCalendar,
                        style: TextStyle(
                          color: context.colors.primary,
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          AppStrings.noVisitsToday,
                          style: TextStyle(
                            color: context.colors.textQuaternary,
                          ),
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
          color: isSelected ? Colors.transparent : Colors.grey.withValues(alpha: 0.3),
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
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

class _AdminUnlockTitle extends StatefulWidget {
  const _AdminUnlockTitle();

  @override
  State<_AdminUnlockTitle> createState() => _AdminUnlockTitleState();
}

class _AdminUnlockTitleState extends State<_AdminUnlockTitle> {
  int _tapCount = 0;
  DateTime? _lastTapTime;

  void _handleTap() {
    final now = DateTime.now();
    if (_lastTapTime == null || now.difference(_lastTapTime!) > const Duration(seconds: 1)) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    _lastTapTime = now;

    if (_tapCount == 7) {
      _tapCount = 0;
      _showAdminPasswordDialog();
    }
  }

  void _showAdminPasswordDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Admin Unlock'),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Enter Admin Password',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final password = controller.text;
              final unlocked = context.read<RoleCubit>().unlockAdmin(password);
              Navigator.pop(ctx);
              if (unlocked) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Admin Mode Unlocked')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Incorrect Password')),
                );
              }
            },
            child: const Text('Unlock'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Text(
        AppStrings.appTitle,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
              height: 1.1,
            ),
      ),
    );
  }
}
