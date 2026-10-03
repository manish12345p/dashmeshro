import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/history_item.dart';
import 'history_remote_data_source.dart';

/// Supabase implementation of [IHistoryRemoteDataSource].
///
/// Table mapping:
///   services  ← Customer/{id}/services sub-collection (customer_id FK)
///   customers ← Customer collection
class SupabaseHistoryRemoteDataSource implements IHistoryRemoteDataSource {
  final SupabaseClient _client;

  SupabaseHistoryRemoteDataSource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  @override
  Stream<List<HistoryItem>> getAllServices() {
    final controller = StreamController<List<HistoryItem>>.broadcast();

    Future<void> fetchAll() async {
      try {
        // Fetch both customers and services in parallel
        final results = await Future.wait([
          _client.from('customers').select('id, name, number, address'),
          _client.from('services').select(),
        ]);

        final custRows = results[0] as List;
        final svcRows = results[1] as List;

        // Build customer lookup
        final custMap = <String, Map<String, dynamic>>{};
        for (final r in custRows) {
          final row = r as Map<String, dynamic>;
          custMap[row['id'] as String] = row;
        }

        final items = <HistoryItem>[];
        for (final r in svcRows) {
          try {
            final data = r as Map<String, dynamic>;

            final customerId = data['customer_id'] as String? ?? '';
            if (customerId.isEmpty) continue;

            final custData = custMap[customerId];
            // Skip orphaned services
            if (custData == null) continue;

            final dateStr =
                data['service_date'] as String? ??
                data['serviceDate'] as String? ??
                '';
            final serviceDate = DateTime.tryParse(dateStr);
            if (serviceDate == null) continue;

            final customerName =
                data['customer_name'] as String? ??
                custData['name'] as String? ??
                'Unknown';
            final customerPhone =
                data['customer_phone'] as String? ??
                custData['phone'] as String? ??
                '';
            final customerAddress = custData['address'] as String? ?? '';

            items.add(HistoryItem(
              id: data['id'] as String? ?? '',
              customerId: customerId,
              customerName: customerName,
              customerAddress: customerAddress,
              customerPhone: customerPhone,
              serviceType:
                  data['service_type'] as String? ??
                  data['serviceType'] as String? ??
                  '',
              serviceDate: serviceDate,
              note: data['remarks'] as String? ?? '',
              fault: data['fixes'] as String? ?? '',
              status: data['status'] as String? ?? 'pending',
              serviceDuration:
                  data['guarantee'] as String? ??
                  data['service_duration'] as String? ??
                  '',
              guaranteeDuration:
                  data['guarantee'] as String? ??
                  data['guarantee_duration'] as String? ??
                  '',
              totalAmount:
                  (data['total_amount'] as num? ??
                  data['totalAmount'] as num? ??
                  0)
                      .toDouble(),
              amountPaid:
                  (data['amount_paid'] as num? ??
                  data['amountPaid'] as num? ??
                  0)
                      .toDouble(),
              amountPending:
                  (data['amount_pending'] as num? ??
                  data['amountPending'] as num? ??
                  0)
                      .toDouble(),
              isComplaint:
                  data['is_complaint'] as bool? ??
                  data['isComplaint'] as bool? ??
                  false,
            ));
          } catch (e) {
            debugPrint('Error parsing service row: $e');
          }
        }

        items.sort((a, b) => b.serviceDate.compareTo(a.serviceDate));

        if (!controller.isClosed) controller.add(items);
      } catch (e) {
        debugPrint('Supabase error in getAllServices: $e');
        if (!controller.isClosed) controller.add([]);
      }
    }

    fetchAll();

    // Realtime subscription — re-fetch on any change to services or customers
    final channel = _client
        .channel('history_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'services',
          callback: (_) => fetchAll(),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'customers',
          callback: (_) => fetchAll(),
        )
        .subscribe();

    controller.onCancel = () {
      _client.removeChannel(channel);
      controller.close();
    };

    return controller.stream
        .debounceTime(const Duration(milliseconds: 400))
        .handleError((error) {
      debugPrint('Supabase history stream error: $error');
      return <HistoryItem>[];
    });
  }
}
