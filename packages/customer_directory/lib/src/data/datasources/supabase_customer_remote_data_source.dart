import 'dart:async';
import 'dart:convert';
import 'dart:math' as dart_math;
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/customer.dart';
import 'customer_remote_data_source.dart';

/// Supabase implementation of [ICustomerRemoteDataSource].
///
/// Table mapping (Supabase → Firestore equivalent):
///   customers          ← Customer collection
///   services           ← Customer/{id}/services sub-collection  (column: customer_id)
///
/// Expected Supabase table schemas:
/// ```sql
/// -- customers
/// id            text primary key,
/// name          text not null,
/// customer_id   text not null,       -- business-level ID (e.g. CUST-001)
/// number        text not null,
/// address       text default '',
/// locality      text default '',
/// ro_type       text default '',
/// note          text default '',
/// total_amc_visits      int default 0,
/// remaining_amc_visits  int default 0,
/// last_dismissed_reminder text default '',
/// created_at    text not null,
///
/// -- services (child table)
/// id              text primary key,
/// customer_id     text references customers(id) on delete cascade,
/// service_type    text,
/// fixes           text,
/// total_amount    numeric default 0,
/// amount_paid     numeric default 0,
/// amount_pending  numeric default 0,
/// equipments_used text,
/// service_duration    text default '',
/// guarantee_duration  text default '',
/// remarks         text default '',
/// status          text default 'pending',
/// is_complaint    boolean default false,
/// service_date    text not null,
/// customer_name   text,
/// customer_phone  text,
/// is_deleted      boolean default false,
/// created_at      text,
/// ```
class SupabaseCustomerRemoteDataSource implements ICustomerRemoteDataSource {
  final SupabaseClient _client;

  /// [client] defaults to [Supabase.instance.client] if not provided.
  SupabaseCustomerRemoteDataSource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  static List<Customer>? _memCache;

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  /// Converts a Supabase `customers` row + its nested `services` list into a
  /// [Customer] entity that mirrors what [FirebaseCustomerRemoteDataSource]
  /// returns.
  Customer _rowToCustomer(Map<String, dynamic> row) {
    final services = (row['services'] as List<dynamic>? ?? [])
        .map((s) => _serviceRowToActivity(s as Map<String, dynamic>))
        .toList();

    return Customer(
      id: row['id'] as String? ?? '',
      name: row['name'] as String? ?? '',
      customerId: row['customer_id'] as String? ?? '',
      number: row['phone'] as String? ?? row['number'] as String? ?? '',
      address: row['address'] as String? ?? '',
      locality: row['locality'] as String? ?? '',
      roType: row['ro_type'] as String? ?? '',
      note: row['note'] as String? ?? '',
      serviceHistory: services,
      totalAmcVisits: row['total_amc_visits'] as int? ?? 0,
      remainingAmcVisits: row['remaining_amc_visits'] as int? ?? 0,
    );
  }

  ServiceActivity _serviceRowToActivity(Map<String, dynamic> row) {
    return ServiceActivity(
      id: row['id'] as String? ?? '',
      serviceType: row['service_type'] as String? ?? '',
      fixes: row['fixes'] as String? ?? '',
      totalAmount: (row['total_amount'] as num? ?? 0).toDouble(),
      amountPaid: (row['amount_paid'] as num? ?? 0).toDouble(),
      equipmentsUsed: row['equipments_used'] as String? ?? '',
      serviceDuration: row['guarantee'] as String? ?? row['service_duration'] as String? ?? '',
      guaranteeDuration: row['guarantee'] as String? ?? row['guarantee_duration'] as String? ?? '',
      remarks: row['remarks'] as String? ?? '',
      status: row['status'] as String? ?? 'pending',
      isComplaint: row['is_complaint'] as bool? ?? false,
      serviceDate: DateTime.tryParse(row['service_date'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  // ---------------------------------------------------------------------------
  // ICustomerRemoteDataSource implementation
  // ---------------------------------------------------------------------------

  @override
  Stream<List<Customer>> getCustomers() {
    // Supabase Realtime: subscribe to changes on the `customers` table and
    // re-fetch the full list on every change. This mirrors the Firestore
    // snapshots() behaviour.
    final controller = StreamController<List<Customer>>.broadcast();

    if (_memCache != null) {
      Future.microtask(() {
        if (!controller.isClosed) controller.add(_memCache!);
      });
    } else {
      Future.microtask(() async {
        try {
          final prefs = await SharedPreferences.getInstance();
          final cached = prefs.getString('cached_customer_directory_supabase');
          if (cached != null) {
            final List<dynamic> decoded = jsonDecode(cached);
            final cachedItems = decoded.map((e) => Customer.fromJson(e as Map<String, dynamic>)).toList();
            if (!controller.isClosed && _memCache == null) {
              _memCache = cachedItems;
              controller.add(cachedItems);
            }
          }
        } catch (_) {}
      });
    }

    Future<void> fetchAll() async {
      try {
        final allRows = <Map<String, dynamic>>[];
        const pageSize = 1000;
        int from = 0;
        while (true) {
          final rows = await _client
              .from('customers')
              .select('*, services(*)')
              .order('created_at', ascending: false)
              .range(from, from + pageSize - 1);
          final data = rows as List<dynamic>;
          for (final r in data) {
            allRows.add(r as Map<String, dynamic>);
          }
          if (data.length < pageSize) break;
          from += pageSize;
        }

        final customers = allRows
            .map((r) => _rowToCustomer(r as Map<String, dynamic>))
            .toList();

        _memCache = customers;
        if (!controller.isClosed) controller.add(customers);
        
        try {
          final prefs = await SharedPreferences.getInstance();
          final itemsJson = customers.map((c) => c.toJson()).toList();
          prefs.setString('cached_customer_directory_supabase', jsonEncode(itemsJson));
        } catch (_) {}
      } catch (e) {
        debugPrint('Supabase error in getCustomers: $e');
        if (!controller.isClosed) controller.add([]);
      }
    }

    fetchAll();

    final channel = _client
        .channel('customers_changes')
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

    return controller.stream.shareReplay(maxSize: 1);
  }

  @override
  Stream<Customer> getCustomerById(String id) {
    final controller = StreamController<Customer>.broadcast();

    Future<void> fetchOne() async {
      try {
        Map<String, dynamic>? row;
        try {
          row = await _client
              .from('customers')
              .select()
              .eq('id', id)
              .single();
        } catch (e) {
          if (e is PostgrestException && e.message.contains('invalid input syntax for type uuid')) {
            debugPrint('Warning: ID $id is not a UUID. Falling back to search by customer_id column.');
            row = await _client
                .from('customers')
                .select()
                .eq('customer_id', id)
                .single();
          } else {
            rethrow;
          }
        }

        // Fetch services ordered by service_date desc
        List<dynamic> services = [];
        try {
          services = await _client
              .from('services')
              .select()
              .eq('customer_id', id)
              .order('service_date', ascending: false);
        } catch (e) {
          debugPrint('Warning: Failed to fetch services for customer $id: $e');
        }

        final customerData = Map<String, dynamic>.from(row as Map);
        customerData['services'] = services;

        if (!controller.isClosed) {
          controller.add(_rowToCustomer(customerData));
        }
      } catch (e) {
        debugPrint('Supabase error in getCustomerById: $e');
        if (!controller.isClosed) {
          controller.addError(Exception('Failed to load customer: $e'));
        }
      }
    }

    fetchOne();

    // Subscribe to changes on this specific customer row AND its services
    final custChannel = _client
        .channel('customer_${id}_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'customers',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: id,
          ),
          callback: (_) => fetchOne(),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'services',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'customer_id',
            value: id,
          ),
          callback: (_) => fetchOne(),
        )
        .subscribe();

    controller.onCancel = () {
      _client.removeChannel(custChannel);
      controller.close();
    };

    return controller.stream;
  }

  @override
  Future<String> createCustomer(Customer customer) async {
    final id =
        customer.id.isEmpty ? _generateId() : customer.id;

    await _client.from('customers').insert({
      'id': id,
      'name': customer.name,
      'customer_id': customer.customerId,
      'phone': customer.number,
      'address': customer.address,
      'locality': customer.locality,
      'ro_type': customer.roType,
      'note': customer.note,
      'total_amc_visits': customer.totalAmcVisits,
      'remaining_amc_visits': customer.remainingAmcVisits,
      'created_at': DateTime.now().toIso8601String(),
    });

    return id;
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await _client.from('customers').update({
      'name': customer.name,
      'customer_id': customer.customerId,
      'phone': customer.number,
      'address': customer.address,
      'locality': customer.locality,
      'ro_type': customer.roType,
      'note': customer.note,
      'total_amc_visits': customer.totalAmcVisits,
      'remaining_amc_visits': customer.remainingAmcVisits,
    }).eq('id', customer.id);
  }

  @override
  Future<void> deleteCustomer(String id) async {
    // 1. Delete all services for this customer
    await _client.from('services').delete().eq('customer_id', id);

    // 2. Delete all payments for this customer
    await _client.from('payments').delete().eq('customer_id', id);

    // 3. Delete all installments for this customer
    await _client.from('installments').delete().eq('customer_id', id);

    // 4. Delete the customer
    await _client.from('customers').delete().eq('id', id);
  }

  @override
  Future<bool> checkCustomerExistsByPhone(String phone) async {
    final result = await _client
        .from('customers')
        .select('id')
        .eq('phone', phone)
        .limit(1);

    return (result as List).isNotEmpty;
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  String _generateId() {
    final rng = dart_math.Random();
    String generate(int length) {
      final chars = '0123456789abcdef';
      return List.generate(length, (_) => chars[rng.nextInt(chars.length)]).join();
    }
    return '${generate(8)}-${generate(4)}-4${generate(3)}-a${generate(3)}-${generate(12)}';
  }
}
