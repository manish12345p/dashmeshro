import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/home_data.dart';
import 'home_remote_data_source.dart';
import 'package:core/core.dart';

/// Supabase implementation of [IHomeRemoteDataSource].
///
/// Replicates the real-time aggregation from [FirebaseHomeRemoteDataSource]
/// using Supabase Realtime channels.
///
/// Table mapping:
///   customers    → Customer collection
///   services     → Customer/{id}/services (customer_id FK)
///   installments → installments collection
class SupabaseHomeRemoteDataSource implements IHomeRemoteDataSource {
  final SupabaseClient _client;

  SupabaseHomeRemoteDataSource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  @override
  Stream<HomeData> getHomeData() async* {
    // Serve stale cache immediately
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('cached_home_data_supabase');
      if (cached != null) {
        yield HomeData.fromJson(json.decode(cached) as Map<String, dynamic>);
      }
    } catch (_) {}

    final Map<String, Map<String, dynamic>> customers = {};
    final Map<String, Map<String, dynamic>> services = {};
    final Map<String, Map<String, dynamic>> installments = {};
    final controller = StreamController<HomeData>();

    void push() {
      final data = _buildHomeData(
        customers: customers.values.toList(),
        services: services.values.toList(),
        installments: installments.values.toList(),
        now: DateTime.now(),
      );
      try {
        SharedPreferences.getInstance().then(
          (p) => p.setString('cached_home_data_supabase', json.encode(data.toJson())),
        );
      } catch (_) {}
      if (!controller.isClosed) controller.add(data);
    }

    final debouncer = PublishSubject<void>();
    final dSub = debouncer.debounceTime(const Duration(milliseconds: 500)).listen((_) => push());

    Future<List<Map<String, dynamic>>> fetchAllRows(String table) async {
      final allRows = <Map<String, dynamic>>[];
      const pageSize = 1000;
      int from = 0;
      
      while (true) {
        final response = await _client.from(table).select().order('created_at', ascending: false).range(from, from + pageSize - 1);
        final data = response as List<dynamic>;
        for (final r in data) {
          allRows.add(r as Map<String, dynamic>);
        }
        if (data.length < pageSize) break;
        from += pageSize;
      }
      return allRows;
    }

    // Initial load
    try {
      final custRows = await fetchAllRows('customers');
      for (final r in custRows) {
        final row = r as Map<String, dynamic>;
        customers[row['id'] as String] = _mapCustRow(row);
      }
      
      final svcRows = await fetchAllRows('services');
      for (final r in svcRows) {
        final row = r as Map<String, dynamic>;
        row['customerId'] = row['customer_id'];
        services[row['id'] as String] = row;
      }
      
      final instRows = await fetchAllRows('installments');
      for (final r in instRows) {
        final row = r as Map<String, dynamic>;
        row['customerId'] = row['customer_id'];
        installments[row['id'] as String] = row;
      }
      
      push();
    } catch (e, stack) {
      debugPrint('!!! FATAL Supabase home initial fetch error: $e');
      debugPrint('Stacktrace: $stack');
      // Attempt to push whatever data we have so far instead of freezing
      try {
        push();
      } catch (innerE) {
        debugPrint('!!! FATAL push() error: $innerE');
      }
    }

    // Realtime subscriptions
    final ch = _client
        .channel('home_all')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'customers',
          callback: (p) {
            if (p.eventType == PostgresChangeEvent.delete) {
              customers.remove(p.oldRecord['id']);
            } else if (p.newRecord.isNotEmpty) {
              final id = p.newRecord['id'] as String;
              customers[id] = _mapCustRow(p.newRecord);
            }
            debouncer.add(null);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'services',
          callback: (p) {
            if (p.eventType == PostgresChangeEvent.delete) {
              services.remove(p.oldRecord['id']);
            } else if (p.newRecord.isNotEmpty) {
              final r = Map<String, dynamic>.from(p.newRecord);
              r['customerId'] = r['customer_id'];
              services[r['id'] as String] = r;
            }
            debouncer.add(null);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'installments',
          callback: (p) {
            if (p.eventType == PostgresChangeEvent.delete) {
              installments.remove(p.oldRecord['id']);
            } else if (p.newRecord.isNotEmpty) {
              final r = Map<String, dynamic>.from(p.newRecord);
              r['customerId'] = r['customer_id'];
              installments[r['id'] as String] = r;
            }
            debouncer.add(null);
          },
        )
        .subscribe();

    controller.onCancel = () {
      _client.removeChannel(ch);
      dSub.cancel();
      debouncer.close();
    };

    yield* controller.stream;
  }

  Map<String, dynamic> _mapCustRow(Map<String, dynamic> r) => {
        'id': r['id'],
        'name': r['name'],
        'number': r['phone'],
        'address': r['address'],
        'ro_type': r['ro_type'],
        'created_at': r['created_at'],
        'lastDismissedReminder': r['last_dismissed_reminder'],
      };

  @override
  Future<void> createHomeData(HomeData data) async {}
  @override
  Future<void> updateHomeData(HomeData data) async {}
  @override
  Future<void> deleteHomeData(String id) async {}
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

DateTime? _exp(String date, String dur) {
  if (date.isEmpty || dur.isEmpty) return null;
  try {
    final d = DateTime.parse(date);
    final p = dur.trim().split(' ');
    if (p.length != 2) return null;
    final v = int.tryParse(p[0]) ?? 0;
    final u = p[1].toLowerCase();
    if (u.contains('month')) return DateTime(d.year, d.month + v, d.day);
    if (u.contains('year')) return DateTime(d.year + v, d.month, d.day);
  } catch (_) {}
  return null;
}

HomeData _buildHomeData({
  required List<Map<String, dynamic>> customers,
  required List<Map<String, dynamic>> services,
  required List<Map<String, dynamic>> installments,
  required DateTime now,
}) {
  final today = now.toIso8601String().split('T')[0];
  final thisMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';
  final custById = <String, Map<String, dynamic>>{for (final c in customers) c['id'] as String: c};

  int activeAmcs = 0;
  for (final c in custById.values) {
    if ((c['ro_type'] as String? ?? '').toLowerCase().contains('amc')) activeAmcs++;
  }

  final latestSvc = <String, DateTime>{};
  for (final s in services) {
    // s['deleted_at'] does not exist on services
    final cid = (s['customerId'] ?? s['customer_id']) as String? ?? '';
    final ds = s['service_date'] as String? ?? s['serviceDate'] as String? ?? '';
    if (ds.isEmpty) continue;
    try {
      final d = DateTime.parse(ds);
      if (!latestSvc.containsKey(cid) || d.isAfter(latestSvc[cid]!)) latestSvc[cid] = d;
    } catch (_) {}
  }

  int totalSvc = 0, amcSvc = 0, newRoSvc = 0, repairSvc = 0;
  int todaySells = 0, weekSells = 0, lastWeekSells = 0, pendingCmpl = 0;
  double collected = 0;

  final schedules = <ScheduleItem>[];
  final complaints = <ComplaintItem>[];
  final notifs = <NotificationItem>[];
  final expiring = <ExpiryItem>[];
  final pendingPay = <PendingPaymentItem>[];
  final pendingSvcs = <PendingServiceItem>[];
  final explicitDue = <String>{};

  DateTime _baseDate(String cid) {
    if (latestSvc.containsKey(cid)) return latestSvc[cid]!;
    final ca = custById[cid]?['created_at'];
    return (ca is String && ca.isNotEmpty) ? (DateTime.tryParse(ca) ?? now) : now;
  }

  // First-pass 3-month reminders
  for (final c in custById.values) {
    final cid = c['id'] as String;
    final nextR = ReminderUtils.getNextOrOverdueReminder(_baseDate(cid));
    final isToday = nextR.year == now.year && nextR.month == now.month && nextR.day == now.day;
    final diff = nextR.difference(DateTime(now.year, now.month, now.day)).inDays;
    final isOver = diff < 0 && diff >= -3;
    final dismissed = c['lastDismissedReminder'] as String?;
    bool isDismissed = false;
    if (dismissed != null && dismissed.isNotEmpty) {
      try {
        final dd = DateTime.parse(dismissed);
        if (!DateTime(nextR.year, nextR.month, nextR.day).isAfter(DateTime(dd.year, dd.month, dd.day))) isDismissed = true;
      } catch (_) {}
    }
    final name = c['name'] as String? ?? 'Unknown';
    final phone = c['phone'] as String? ?? '';
    if (isToday && schedules.length < 5) {
      schedules.add(ScheduleItem(title: '3-Month Service - $name', subtitle: 'Routine Maintenance', time: 'Due Today', isUrgent: false));
    }
    if (isToday || isOver) {
      final fd = nextR.toIso8601String().split('T')[0];
      notifs.add(NotificationItem(customerName: name, customerId: cid, address: c['address'] as String? ?? '', serviceType: '3-Month Recurring Service', serviceId: 'reminder_${nextR.millisecondsSinceEpoch}', notificationDate: fd, isDismissed: isDismissed, phone: phone, note: isOver ? 'Overdue Service' : 'Service Due', amount: 0, serviceDate: fd));
    }
  }

  // Installments
  for (final inst in installments) {
    final cid = (inst['customerId'] ?? inst['customer_id']) as String? ?? '';
    final c = custById[cid];
    if (c == null) continue;
    final isRent = inst['is_rent'] as bool? ?? false;
    final status = inst['status'] as String? ?? 'pending';
    final due = inst['due_date'] as String? ?? '';
    final name = c['name'] as String? ?? 'Unknown';
    final phone = c['phone'] as String? ?? '';
    if (isRent && (status == 'pending' || status == 'overdue') && due.isNotEmpty) {
      try {
        final dd = DateTime.parse(due);
        if (dd.year == now.year && dd.month == now.month && (dd.isBefore(now) || due.startsWith(today))) {
          notifs.add(NotificationItem(customerName: name, customerId: cid, address: c['address'] as String? ?? '', serviceType: 'Rent Due', serviceId: inst['id'] as String? ?? '', notificationDate: due, isDismissed: false, phone: phone, note: '', amount: (inst['total_amount'] as num? ?? 0).toDouble(), serviceDate: ''));
        }
        final d = dd.difference(now).inDays;
        if (d <= 7 && d >= -30) pendingPay.add(PendingPaymentItem(customerName: name, customerId: cid, amountPending: (inst['total_amount'] as num? ?? 0).toDouble(), phone: phone, daysOverdue: -d, dueDate: due, type: 'Rent'));
      } catch (_) {}
    }
  }

  // Services
  debugPrint('=== HOME DEBUG: Total services in memory: ${services.length} ===');
  debugPrint('=== HOME DEBUG: Total customers in memory: ${custById.length} ===');
  int _skippedNoCust = 0;
  int _passedFilter = 0;
  int _failedFilter = 0;
  for (final s in services) {
    // s['deleted_at'] does not exist on services
    final cid = (s['customerId'] ?? s['customer_id']) as String? ?? '';
    final c = custById[cid];
    if (c == null) {
      _skippedNoCust++;
      // Log ALL services that have no matching customer
      final sDate = s['service_date'] as String? ?? s['serviceDate'] as String? ?? '';
      if (sDate.startsWith(today)) {
        debugPrint('!!! HOME DEBUG: TODAY visit SKIPPED (no customer match) !!!');
        debugPrint('  service id: ${s['id']}');
        debugPrint('  customer_id on service: "$cid"');
        debugPrint('  service_date: $sDate');
        debugPrint('  service_type: ${s['service_type'] ?? s['serviceType']}');
        debugPrint('  status: ${s['status']}');
        debugPrint('  Customer IDs in map (first 10): ${custById.keys.take(10).toList()}');
      }
      continue;
    }
    final type = (s['service_type'] as String? ?? s['serviceType'] as String? ?? '').toLowerCase().trim();
    final rawStatus = s['status'] as String?;
    final status = (rawStatus == null || rawStatus.isEmpty) ? 'pending' : rawStatus.trim().toLowerCase();
    final isDeleted = s['is_deleted'] == true || s['is_deleted'] == 'true' || s['deleted_at'] != null;
    
    if (isDeleted) {
      _failedFilter++;
      continue;
    }
    final date = s['service_date'] as String? ?? s['serviceDate'] as String? ?? '';
    final paid = (s['amount_paid'] as num? ?? s['amountPaid'] as num? ?? 0).toDouble();
    final amtP = (s['amount_pending'] as num? ?? s['amountPending'] as num? ?? 0).toDouble();
    final sDur = s['guarantee'] as String? ?? s['service_duration'] as String? ?? '';
    final gDur = s['guarantee'] as String? ?? s['guarantee_duration'] as String? ?? '';
    final name = c['name'] as String? ?? 'Unknown';
    final phone = c['number'] as String? ?? c['phone'] as String? ?? '';
    final addr = c['address'] as String? ?? '';

    if (date.startsWith(thisMonth)) collected += paid;
    totalSvc++;
    if (type.contains('amc')) {
      amcSvc++;
    } else if (type.contains('new ro')) {
      newRoSvc++;
      if (date.startsWith(today)) todaySells++;
      try {
        final sd = DateTime.parse(date);
        final d = now.difference(sd).inDays;
        if (d >= 0 && d <= 7) {
          weekSells++;
        } else if (d > 7 && d <= 14) {
          lastWeekSells++;
        }
      } catch (_) {}
    } else if (type.contains('service') || type.contains('repair')) {
      repairSvc++;
    }

    final sExp = _exp(date, sDur);
    final gExp = _exp(date, gDur);

    if ((date == today || status == 'in_progress') && schedules.length < 5) {
      schedules.add(ScheduleItem(title: '${s['service_type'] ?? s['serviceType']} - $name', subtitle: s['remarks'] as String? ?? 'No remarks', time: sExp != null ? 'Due: ${sExp.day}/${sExp.month}/${sExp.year}' : date, isUrgent: status == 'in_progress'));
    }

    if (sExp != null && sExp.year == now.year && sExp.month == now.month && sExp.day == now.day) {
      notifs.add(NotificationItem(customerName: name, customerId: cid, address: addr, serviceType: '$type · Due: ${sExp.day}/${sExp.month}/${sExp.year}', serviceId: s['id'] as String? ?? '', notificationDate: sExp.toIso8601String().split('T')[0], isDismissed: s['is_dismissed'] as bool? ?? false, phone: phone, note: s['fixes'] as String? ?? '', amount: (s['total_amount'] as num? ?? 0).toDouble(), serviceDate: date));
    }

    void addExp(DateTime e, String kind, String dur) {
      final d = e.difference(now).inDays;
      if (d <= 7 && d >= -30) {
        expiring.add(ExpiryItem(customerName: name, customerId: cid, type: kind, expiryDate: e.toIso8601String().split('T')[0], phone: phone, daysLeft: d, serviceType: type, duration: dur));
        if (kind == 'Service') {
          explicitDue.add(cid);
        }
      }
    }
    if (sExp != null) addExp(sExp, 'Service', sDur);
    if (gExp != null) addExp(gExp, 'Guarantee', gDur);

    if (amtP > 0) pendingPay.add(PendingPaymentItem(customerName: name, customerId: cid, amountPending: amtP, phone: phone, daysOverdue: 0, dueDate: date, type: 'Service Payment'));
    if (status == 'pending' && type.contains('complaint')) { pendingCmpl++; complaints.add(ComplaintItem(customerName: name, customerId: cid, issueType: type, status: 'pending')); }
    
    final completedAtStr = s['completed_at'] as String? ?? s['completedAt'] as String? ?? '';
    bool isRecentlyCompleted = false;
    if (status == 'completed') {
      if (completedAtStr.isNotEmpty) {
        try {
          final compDate = DateTime.parse(completedAtStr);
          if (now.difference(compDate).inHours < 24) isRecentlyCompleted = true;
        } catch (_) {}
      }
      if (!isRecentlyCompleted && date.startsWith(today)) {
        isRecentlyCompleted = true;
      }
    }

    final passesPendingFilter = status == 'pending' || isRecentlyCompleted;

    // Log today's visits specifically
    if (date.startsWith(today)) {
      debugPrint('--- HOME DEBUG: TODAY VISIT ---');
      debugPrint('  id: ${s['id']}');
      debugPrint('  cid: $cid');
      debugPrint('  name: $name');
      debugPrint('  type: $type');
      debugPrint('  rawStatus: "$rawStatus"');
      debugPrint('  status: "$status"');
      debugPrint('  date: $date');
      debugPrint('  passesPendingFilter: $passesPendingFilter');
      debugPrint('------------------------------');
    }

    if (passesPendingFilter) {
      _passedFilter++;
      pendingSvcs.add(PendingServiceItem(id: s['id'] as String? ?? '', customerId: cid, customerName: name, phone: phone, address: addr, serviceType: type, serviceDate: date, status: status, note: s['fixes'] as String? ?? '', isComplaint: type.contains('complaint'), amountPending: amtP));
      explicitDue.add(cid);
    } else {
      _failedFilter++;
    }
  }
  debugPrint('=== HOME DEBUG SUMMARY ===');
  debugPrint('  Skipped (no customer): $_skippedNoCust');
  debugPrint('  Passed pending filter: $_passedFilter');
  debugPrint('  Failed pending filter: $_failedFilter');
  debugPrint('  pendingSvcs count: ${pendingSvcs.length}');
  debugPrint('==========================');

  // Second-pass reminders
  for (final c in custById.values) {
    final cid = c['id'] as String;
    if (explicitDue.contains(cid)) continue;
    final nextR = ReminderUtils.getNextOrOverdueReminder(_baseDate(cid));
    final isToday = nextR.year == now.year && nextR.month == now.month && nextR.day == now.day;
    final diff = nextR.difference(DateTime(now.year, now.month, now.day)).inDays;
    final isOver = diff < 0 && diff >= -7;
    if (isToday || isOver) {
      schedules.add(ScheduleItem(title: c['name'] as String? ?? 'Unknown', subtitle: '3-Month Recurring Service', time: isOver ? 'Overdue' : 'Today', isUrgent: isOver, phone: c['phone'] as String? ?? '', customerId: cid));
    }
  }

  String growth = '0% vs LW';
  if (lastWeekSells > 0) {
    final g = ((weekSells - lastWeekSells) / lastWeekSells) * 100;
    growth = '${g >= 0 ? '+' : ''}${g.round()}% vs LW';
  } else if (weekSells > 0) {
    growth = '+100% vs LW';
  }

  pendingSvcs.sort((a, b) {
    try {
      final da = DateTime.parse(a.serviceDate);
      final db = DateTime.parse(b.serviceDate);
      return db.compareTo(da);
    } catch (_) {
      return 0;
    }
  });

  return HomeData(newSells: 0, activeRentals: 0, activeAmcs: activeAmcs, totalServices: totalSvc, totalCollectedThisMonth: collected, amcServices: amcSvc, newRoServices: newRoSvc, repairServices: repairSvc, resolutionRatePercent: 100, pendingComplaintsCount: pendingCmpl, todaySchedules: schedules, pendingComplaints: complaints, pendingServices: pendingSvcs, amcProgresses: const [], todayNotifications: notifs, expiringItems: expiring, pendingPayments: pendingPay, todaySellsSummary: todaySells, weekSellsSummary: weekSells, projectedGrowth: growth);
}
