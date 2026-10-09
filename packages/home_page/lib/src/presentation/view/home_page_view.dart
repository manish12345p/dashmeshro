import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:core/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:home_page/src/domain/entities/home_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_page/src/presentation/bloc/home_bloc.dart';
import 'package:visit_entry/visit_entry.dart';

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
import '../widgets/manage_service_types_dialog.dart';

class HomePageView extends StatelessWidget {
  final HomeBloc? bloc;

  const HomePageView({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final b = bloc ?? sl<HomeBloc>();
        if (bloc == null) {
          b.add(const HomeEvent.loadHomeData());
        }
        return b;
      },
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
            return Column(
              children: [
                // Fixed App Bar Area
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppPadding.p16, AppPadding.p16, AppPadding.p16, AppPadding.p8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const _AdminUnlockTitle(),
                          const SizedBox(width: AppPadding.p4),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: VisitSearchDelegate(),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search, size: 20, color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Search Customer',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.settings_outlined),
                            onSelected: (value) {
                              if (value == 'ro_types') {
                                ManageRoTypesDialog.show(context);
                              } else if (value == 'service_types') {
                                ManageServiceTypesDialog.show(context);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'ro_types',
                                child: Text('Manage RO Types'),
                              ),
                              const PopupMenuItem(
                                value: 'service_types',
                                child: Text('Manage Service Types'),
                              ),
                            ],
                          ),
                          _NotificationBell(data: data),
                        ],
                      ),
                    ],
                  ),
                ),
                // Scrollable Content
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          AppPadding.p16,
                          AppPadding.p8,
                          AppPadding.p16,
                          AppPadding.p16,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            // Top Summary Cards (2x2 Grid)
                            Row(
                              children: [
                                Expanded(
                                  child: SummaryCard(
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
                                ),
                                const SizedBox(width: AppPadding.p12),
                                Expanded(
                                  child: SummaryCard(
                                    overlineText: AppStrings.newRo,
                                    valueText: '${data.newRoServices}',
                                    subtitleText: AppStrings.newRoSubtitle,
                                    trailingIcon: Icon(
                                      Icons.water_drop,
                                      color: context.colors.primary,
                                      size: 20,
                                    ),
                                    trailingBackgroundColor: context.colors.primary.withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppPadding.p12),
                            Row(
                              children: [
                                Expanded(
                                  child: SummaryCard(
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
                                ),
                                const SizedBox(width: AppPadding.p12),
                                Expanded(
                                  child: SummaryCard(
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
                                ),
                              ],
                            ),
                            const SizedBox(height: AppPadding.p32),

                            // Quick Actions
                            _CalendarStatusCard(data: data),
                            const SizedBox(height: AppPadding.p12),
                            SizedBox(
                              width: double.infinity,
                              child: _QuickActionBtn(
                                icon: Icons.edit_document,
                                label: 'Estimates',
                                color: context.colors.primary,
                                onTap: () => context.push('/estimates'),
                                isHorizontal: true,
                              ),
                            ),
                            const SizedBox(height: AppPadding.p32),

                            // Pending Services
                            SectionHeader(
                              title: 'Pending Section',
                              trailing: const SizedBox(),
                            ),
                            const SizedBox(height: AppPadding.p16),
                          ]),
                        ),
                      ),
                      if (data.pendingServices.isNotEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                            AppPadding.p16, 
                            0, 
                            AppPadding.p16, 
                            AppPadding.p48 + 80,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: _PendingServiceCard(item: data.pendingServices[index]),
                                );
                              },
                              childCount: data.pendingServices.length,
                            ),
                          ),
                        ),
                      if (data.pendingServices.isEmpty)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppPadding.p16,
                              AppPadding.p16,
                              AppPadding.p16,
                              AppPadding.p48 + 80,
                            ),
                            child: Center(
                              child: Text(
                                'No pending services currently',
                                style: TextStyle(
                                  color: context.colors.textQuaternary,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
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

class _PendingServiceCard extends StatefulWidget {
  final PendingServiceItem item;

  const _PendingServiceCard({required this.item});

  @override
  State<_PendingServiceCard> createState() => _PendingServiceCardState();
}

class _PendingServiceCardState extends State<_PendingServiceCard> {
  bool? _optimisticIsCompleted;

  @override
  void didUpdateWidget(covariant _PendingServiceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.status != widget.item.status) {
       _optimisticIsCompleted = null;
    }
  }

  String _getServiceDetailsText() {
    return '''*Pending Service Details*
Customer: ${widget.item.customerName}
Phone: ${widget.item.phone}
Address: ${widget.item.address}
Service: ${widget.item.serviceType}
Date: ${widget.item.serviceDate}
${widget.item.amountPending > 0 ? 'Pending Amount: ₹${widget.item.amountPending.toStringAsFixed(2)}\n' : ''}${widget.item.note.isNotEmpty ? 'Note: ${widget.item.note}' : ''}'''.trim();
  }

  void _toggleDone(bool isDone) async {
    setState(() => _optimisticIsCompleted = isDone);
    
    final updates = <String, dynamic>{
      'status': isDone ? 'completed' : 'pending',
    };
    if (isDone) {
      updates['completed_at'] = DateTime.now().toIso8601String();
    }

    try {
      final response = await Supabase.instance.client
          .from('services')
          .update(updates)
          .eq('id', widget.item.id)
          .select('status, completed_at');
      debugPrint('[_toggleDone] Supabase raw stored value for ${widget.item.id}: $response');
    } catch (e) {
      // If completed_at column doesn't exist, try without it
      if (e.toString().contains('completed_at')) {
        updates.remove('completed_at');
        try {
          final response2 = await Supabase.instance.client
              .from('services')
              .update(updates)
              .eq('id', widget.item.id)
              .select('status');
          debugPrint('[_toggleDone] Supabase raw stored value (fallback) for ${widget.item.id}: $response2');
          return;
        } catch (_) {}
      }
      if (mounted) {
        setState(() => _optimisticIsCompleted = null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating status: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[_PendingServiceCard.build] Building card for ${widget.item.id}. Local _optimisticIsCompleted: $_optimisticIsCompleted, widget.item.status: ${widget.item.status}');
    final isCompleted = _optimisticIsCompleted ?? (widget.item.status == 'completed');
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted 
              ? Colors.grey.shade200 
              : (widget.item.isComplaint ? Colors.red.withOpacity(0.3) : Colors.grey.shade200),
          width: 1.5,
        ),
        boxShadow: isCompleted ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isCompleted ? null : () {
            EditVisitDialog.show(context, customerId: widget.item.customerId, serviceId: widget.item.id);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _toggleDone(!isCompleted),
                      child: Container(
                        width: 26,
                        height: 26,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCompleted ? Colors.green : Colors.red,
                            width: 2,
                          ),
                          color: isCompleted ? Colors.green : Colors.transparent,
                        ),
                        child: isCompleted ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.item.customerName,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: isCompleted ? Colors.grey.shade500 : context.colors.textPrimary,
                                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                              ),
                              if (widget.item.isComplaint)
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.red.shade100),
                                  ),
                                  child: const Text(
                                    'COMPLAINT',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 14, color: isCompleted ? Colors.grey.shade400 : context.colors.textSecondary),
                              const SizedBox(width: 6),
                              Text(
                                '${widget.item.serviceDate}  •  ${widget.item.serviceType}',
                                style: textTheme.bodySmall?.copyWith(
                                  color: isCompleted ? Colors.grey.shade500 : context.colors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (widget.item.phone.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.phone_outlined, size: 14, color: isCompleted ? Colors.grey.shade400 : context.colors.textSecondary),
                                const SizedBox(width: 6),
                                Text(
                                  widget.item.phone,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: isCompleted ? Colors.grey.shade500 : context.colors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (widget.item.note.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isCompleted ? Colors.grey.shade100 : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isCompleted ? Colors.transparent : Colors.blue.shade100),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 18,
                          color: isCompleted ? Colors.grey.shade400 : Colors.blue.shade600,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.item.note,
                            style: textTheme.bodySmall?.copyWith(
                              color: isCompleted ? Colors.grey.shade500 : Colors.blue.shade900,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (!isCompleted) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ServiceActionRow(
                          phone: widget.item.phone,
                          serviceDetailsText: _getServiceDetailsText(),
                          isDisabled: false,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: context.colors.surfaceSecondary,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                EditVisitDialog.show(context, customerId: widget.item.customerId, serviceId: widget.item.id);
                              },
                              icon: Icon(Icons.edit_outlined, size: 18, color: context.colors.primary),
                              tooltip: 'Edit',
                              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: context.colors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                context.push('/customers/${widget.item.customerId}');
                              },
                              icon: Icon(Icons.person_outline, size: 18, color: context.colors.primary),
                              tooltip: 'Profile',
                              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isHorizontal;

  const _QuickActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: isHorizontal ? 16 : 16, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: isHorizontal
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class _CalendarStatusCard extends StatelessWidget {
  final HomeData data;
  
  const _CalendarStatusCard({required this.data});
  
  @override
  Widget build(BuildContext context) {
    int remaining = 0;
    
    for (var s in data.pendingServices) {
      if (s.status == 'completed') continue;
      remaining++;
    }

    for (var ts in data.todaySchedules) {
      remaining++;
    }
    
    final hasAlert = remaining > 0;
    final color = context.colors.primary;
    
    return Material(
      color: hasAlert ? Colors.red.withOpacity(0.08) : color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => context.go('/calendar'),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: hasAlert ? Colors.red.withOpacity(0.4) : color.withOpacity(0.2), width: hasAlert ? 1.5 : 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month, color: hasAlert ? Colors.red.shade700 : color, size: 24),
              const SizedBox(width: 12),
              Text(
                "Today's Scheduled Visit",
                style: TextStyle(
                  color: hasAlert ? Colors.red.shade800 : color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (hasAlert) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 12, color: Colors.red),
                      const SizedBox(width: 4),
                      Text('Action Needed', style: TextStyle(color: Colors.red.shade800, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationBell extends StatefulWidget {
  final HomeData data;
  const _NotificationBell({required this.data});

  @override
  State<_NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<_NotificationBell> {
  bool _hasUnread = false;

  @override
  void initState() {
    super.initState();
    _checkUnread();
  }

  @override
  void didUpdateWidget(covariant _NotificationBell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _checkUnread();
    }
  }

  Future<void> _checkUnread() async {
    final prefs = await SharedPreferences.getInstance();
    final seenList = prefs.getStringList('seen_notifications') ?? <String>[];
    final seenSet = seenList.toSet();
    
    bool hasNew = false;
    
    for (var n in widget.data.todayNotifications) {
      if (!seenSet.contains(n.serviceId)) { hasNew = true; break; }
    }
    
    if (!hasNew) {
      for (var e in widget.data.expiringItems) {
        final id = '${e.customerId}_${e.type}_${e.expiryDate}';
        if (!seenSet.contains(id)) { hasNew = true; break; }
      }
    }
    
    if (!hasNew) {
      for (var p in widget.data.pendingPayments) {
        final id = '${p.customerId}_payment_${p.dueDate}';
        if (!seenSet.contains(id)) { hasNew = true; break; }
      }
    }
    
    if (mounted) setState(() => _hasUnread = hasNew);
  }

  void _openNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final seenList = prefs.getStringList('seen_notifications') ?? <String>[];
    final seenSet = seenList.toSet();
    
    for (var n in widget.data.todayNotifications) {
      seenSet.add(n.serviceId);
    }
    for (var e in widget.data.expiringItems) {
      seenSet.add('${e.customerId}_${e.type}_${e.expiryDate}');
    }
    for (var p in widget.data.pendingPayments) {
      seenSet.add('${p.customerId}_payment_${p.dueDate}');
    }
    
    await prefs.setStringList('seen_notifications', seenSet.toList());
    
    if (mounted) {
      setState(() => _hasUnread = false);
      NotificationDialog.show(context, widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: _openNotifications,
        ),
        if (_hasUnread)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 10,
                minHeight: 10,
              ),
            ),
          ),
      ],
    );
  }
}
