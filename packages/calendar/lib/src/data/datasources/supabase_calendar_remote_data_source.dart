import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:core/core.dart';
import '../../domain/entities/schedule_item.dart';
import 'calendar_remote_data_source.dart';

/// Supabase implementation of [ICalendarRemoteDataSource].
///
/// Table mapping:
///   customers ← Customer collection
///   services  ← Customer/{id}/services (customer_id FK)
class SupabaseCalendarRemoteDataSource implements ICalendarRemoteDataSource {
  final SupabaseClient _client;

  SupabaseCalendarRemoteDataSource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  DateTime? _dueDate(String dateStr, String durationStr) {
    if (dateStr.isEmpty || durationStr.isEmpty) return null;
    try {
      final d = DateTime.parse(dateStr);
      final p = durationStr.trim().split(' ');
      if (p.length != 2) return null;
      final v = int.tryParse(p[0]) ?? 0;
      final u = p[1].toLowerCase();
      if (u.contains('month')) return DateTime(d.year, d.month + v, d.day);
      if (u.contains('year')) return DateTime(d.year + v, d.month, d.day);
    } catch (_) {}
    return null;
  }

  @override
  Stream<List<ScheduleItem>> getSchedulesForMonth(int year, int month) {
    final controller = StreamController<List<ScheduleItem>>.broadcast();

    Future<List<Map<String, dynamic>>> fetchAllRows(String table) async {
      final allRows = <Map<String, dynamic>>[];
      const pageSize = 1000;
      int from = 0;
      
      while (true) {
        final response = await _client.from(table).select().range(from, from + pageSize - 1);
        final data = response as List<dynamic>;
        for (final r in data) {
          allRows.add(r as Map<String, dynamic>);
        }
        if (data.length < pageSize) break;
        from += pageSize;
      }
      return allRows;
    }

    Future<void> fetchAll() async {
      try {
        final results = await Future.wait([
          fetchAllRows('customers'),
          fetchAllRows('services'),
        ]);

        final custRows = results[0] as List;
        final svcRows = results[1] as List;

        final custMap = <String, Map<String, dynamic>>{};
        for (final r in custRows) {
          final row = r as Map<String, dynamic>;
          custMap[row['id'] as String] = row;
        }

        final items = <ScheduleItem>[];
        final latestSvcDates = <String, DateTime>{};
        final custWithItems = <String>{};

        for (final r in svcRows) {
          final data = r as Map<String, dynamic>;
          final customerId = data['customer_id'] as String? ?? '';
          if (customerId.isEmpty || !custMap.containsKey(customerId)) continue;

          final custData = custMap[customerId]!;
          final customerName = custData['name'] as String? ?? 'Unknown';
          final customerAddress = custData['address'] as String? ?? '';
          final phone = custData['phone'] as String? ?? '';

          final dateStr = data['service_date'] as String? ?? data['serviceDate'] as String? ?? '';
          final serviceDuration = data['guarantee'] as String? ?? data['service_duration'] as String? ?? data['serviceDuration'] as String? ?? '';
          final serviceType = data['service_type'] as String? ?? data['serviceType'] as String? ?? 'General';
          final status = data['status'] as String? ?? 'pending';

          if (dateStr.isNotEmpty) {
            try {
              final d = DateTime.parse(dateStr);
              if (!latestSvcDates.containsKey(customerId) || d.isAfter(latestSvcDates[customerId]!)) {
                latestSvcDates[customerId] = d;
              }
            } catch (_) {}
          }

          final due = _dueDate(dateStr, serviceDuration);
          bool added = false;

          if (due != null && due.year == year && due.month == month) {
            items.add(ScheduleItem(
              id: '${data['id']}_due',
              name: customerName,
              machineId: customerAddress.isNotEmpty ? customerAddress : 'N/A',
              time: 'Due ${due.day}/${due.month}/${due.year}',
              category: serviceType,
              badgeLabel: '$serviceType${serviceDuration.isNotEmpty ? ' · $serviceDuration' : ''}',
              status: status,
              date: due,
              phone: phone,
              customerId: customerId,
              isDismissed: data['is_dismissed'] as bool? ?? data['isDismissed'] as bool? ?? false,
            ));
            added = true;
          } else if (status == 'pending' && dateStr.isNotEmpty) {
            try {
              final pendingDate = DateTime.parse(dateStr);
              if (pendingDate.year == year && pendingDate.month == month) {
                items.add(ScheduleItem(
                  id: '${data['id']}_pending',
                  name: customerName,
                  machineId: customerAddress.isNotEmpty ? customerAddress : 'N/A',
                  time: '${pendingDate.day}/${pendingDate.month}/${pendingDate.year}',
                  category: serviceType,
                  badgeLabel: 'Pending: $serviceType',
                  status: status,
                  date: pendingDate,
                  phone: phone,
                  customerId: customerId,
                  isDismissed: data['is_dismissed'] as bool? ?? false,
                ));
                added = true;
              }
            } catch (_) {}
          }

          if (added) custWithItems.add(customerId);
        }

        // 3-month recurring reminders
        for (final cid in custMap.keys) {
          if (custWithItems.contains(cid)) continue;
          final custData = custMap[cid]!;
          final customerName = custData['name'] as String? ?? 'Unknown';
          final customerAddress = custData['address'] as String? ?? '';
          final phone = custData['phone'] as String? ?? '';

          DateTime baseDate;
          if (latestSvcDates.containsKey(cid)) {
            baseDate = latestSvcDates[cid]!;
          } else {
            final ca = custData['created_at'] as String?;
            baseDate = (ca != null && ca.isNotEmpty) ? (DateTime.tryParse(ca) ?? DateTime.now()) : DateTime.now();
          }

          final reminders = ReminderUtils.getRemindersForMonth(baseDate, year, month);
          for (final date in reminders) {
            items.add(ScheduleItem(
              id: '${cid}_3month_due',
              name: customerName,
              machineId: customerAddress.isNotEmpty ? customerAddress : 'N/A',
              time: 'Due ${date.day}/${date.month}/${date.year}',
              category: '3-Month Recurring Service',
              badgeLabel: '3-Month Recurring Service',
              status: 'pending',
              date: date,
              phone: phone,
              customerId: cid,
              isDismissed: false,
            ));
          }
        }

        // Deduplicate
        final unique = <String, ScheduleItem>{};
        for (final item in items) {
          final key = '${item.name}_${item.machineId}_${item.time}_${item.category}';
          unique[key] = item;
        }

        final sorted = unique.values.toList()
          ..sort((a, b) => (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));

        if (!controller.isClosed) controller.add(sorted);
      } catch (e) {
        debugPrint('Supabase error in getSchedulesForMonth: $e');
        if (!controller.isClosed) controller.add([]);
      }
    }

    fetchAll();

    final channel = _client
        .channel('calendar_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'customers',
          callback: (_) => fetchAll(),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'services',
          callback: (_) => fetchAll(),
        )
        .subscribe();

    controller.onCancel = () {
      _client.removeChannel(channel);
      controller.close();
    };

    return controller.stream.handleError((error) {
      debugPrint('Supabase calendar stream error: $error');
      return <ScheduleItem>[];
    });
  }

  @override
  Future<void> dismissSchedule(
    String customerId,
    String serviceId,
    bool isDismissed,
  ) async {
    final cleanId = serviceId.replaceFirst('notif_', '').replaceFirst('_due', '').replaceFirst('_pending', '');
    await _client
        .from('services')
        .update({'is_dismissed': isDismissed})
        .eq('id', cleanId);
  }
}
