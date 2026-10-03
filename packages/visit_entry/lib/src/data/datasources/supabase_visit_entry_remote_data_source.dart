import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/visit_record.dart';
import 'visit_entry_remote_data_source.dart';

/// Supabase implementation of [IVisitEntryRemoteDataSource].
///
/// Table mapping:
///   services      ← Customer/{id}/services sub-collection  (column: customer_id)
///   customers     ← Customer collection
///   payments      ← payments collection
///   installments  ← installments collection
///   ro_types      ← RoType collection (a single document with a list field)
///
/// Expected `ro_types` table:
/// ```sql
/// id    serial primary key,
/// name  text not null unique
/// ```
class SupabaseVisitEntryRemoteDataSource implements IVisitEntryRemoteDataSource {
  final SupabaseClient _client;

  SupabaseVisitEntryRemoteDataSource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  @override
  Future<void> createVisitEntry(
    VisitRecord entry, {
    double? emiAmountPerMonth,
    int? totalAmcVisitsToPurchase,
  }) async {
    final docId = entry.id.isEmpty ? _generateId() : entry.id;

    // 1. Fetch customer details for denormalization
    String? customerName;
    String? customerPhone;
    try {
      final custRow = await _client
          .from('customers')
          .select('name, phone')
          .eq('id', entry.customerId)
          .maybeSingle();
      if (custRow != null) {
        customerName = custRow['name'] as String?;
        customerPhone = custRow['phone'] as String?;
      }
    } catch (_) {}

    // 2. Insert service record
    final serviceData = <String, dynamic>{
      'id': docId,
      'customer_id': entry.customerId,
      'service_type': entry.serviceType,
      'service_date': entry.serviceDate.toIso8601String(),
      'remarks': entry.remarks,
      'is_urgent': entry.isUrgent,
      'is_complaint': entry.isComplaint,
      'fixes': entry.fixes,
      'amount_paid': entry.amountPaid,
      'amount_pending': entry.amountPending,
      'total_amount': entry.totalAmount,
      'equipments_used': entry.equipmentsUsed,
      'service_duration': entry.serviceDuration,
      'guarantee_duration': entry.guaranteeDuration,
      'status': entry.status,
      'ro_type': entry.roType,
      // 'is_deleted' does not exist in Supabase schema
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'created_at': DateTime.now().toIso8601String(),
    };

    await _client.from('services').insert(serviceData);

    // 3. AMC tracking logic
    if (entry.serviceType.toLowerCase().contains('amc')) {
      try {
        final custRow = await _client
            .from('customers')
            .select('remaining_amc_visits, total_amc_visits')
            .eq('id', entry.customerId)
            .single();

        final remaining = (custRow['remaining_amc_visits'] as int?) ?? 0;

        if (remaining > 0) {
          await _client.from('customers').update({
            'remaining_amc_visits': remaining - 1,
          }).eq('id', entry.customerId);
        } else if (totalAmcVisitsToPurchase != null &&
            totalAmcVisitsToPurchase > 0) {
          await _client.from('customers').update({
            'total_amc_visits': totalAmcVisitsToPurchase,
            'remaining_amc_visits': totalAmcVisitsToPurchase - 1,
          }).eq('id', entry.customerId);
        }
      } catch (_) {}
    }

    // 4. Record payment if amountPaid > 0
    if (entry.amountPaid > 0) {
      try {
        await _client.from('payments').insert({
          'customer_id': entry.customerId,
          'amount': entry.amountPaid,
          'source': 'visit_entry',
          'reference_id': docId,
          'date': DateTime.now().toIso8601String(),
        });
      } catch (_) {}
    }

    // 5. Create EMI installment if there is a pending amount
    if (entry.amountPending > 0) {
      try {
        String name = customerName ?? 'Unknown';
        String address = '';
        String phone = customerPhone ?? '';

        // Fetch full customer for address if we didn't have it
        final custRow = await _client
            .from('customers')
            .select('name, address, phone')
            .eq('id', entry.customerId)
            .maybeSingle();
        if (custRow != null) {
          name = custRow['name'] as String? ?? name;
          address = custRow['address'] as String? ?? '';
          phone = custRow['phone'] as String? ?? phone;
        }

        final contactInfo = [
          if (address.isNotEmpty) address,
          if (phone.isNotEmpty) phone,
        ].join(' | ');

        final emiId = 'emi_$docId';

        double monthlyAmount = entry.amountPending;
        if (emiAmountPerMonth != null &&
            emiAmountPerMonth > 0 &&
            emiAmountPerMonth < entry.amountPending) {
          monthlyAmount = emiAmountPerMonth;
        }

        final now = DateTime.now();
        final initialDueDate = DateTime(now.year, now.month + 1, now.day);

        final svcName = [
          if (entry.serviceType.isNotEmpty) entry.serviceType,
          if (entry.roType != null && entry.roType!.isNotEmpty)
            '(${entry.roType})',
        ].join(' ');

        await _client.from('installments').insert({
          'id': emiId,
          'customer_name': name,
          'customer_id': entry.customerId,
          'vehicle_details': contactInfo,
          'service_name': svcName.isEmpty
              ? 'Service #${docId.substring(0, 5)}'
              : svcName,
          'amount': monthlyAmount,
          'emi_monthly_amount': monthlyAmount,
          'total_amount': entry.amountPending,
          'original_loan_amount': entry.amountPending,
          'status': 'pending',
          'due_date': initialDueDate.toIso8601String(),
          'created_at': now.toIso8601String(),
          'service_id': docId,
        });
      } catch (e) {
        throw Exception('Service saved but EMI/Rent creation failed: $e');
      }
    }
  }

  @override
  Future<List<String>> getRoTypes() async {
    try {
      final rows = await _client.from('ro_types').select('name');
      final types = (rows as List<dynamic>)
          .map((r) => r['name'] as String)
          .toList();
      if (types.isNotEmpty) return types;
    } catch (_) {}
    return ['Commercial', 'Domestic', 'Industrial'];
  }

  @override
  Future<List<Map<String, dynamic>>> searchCustomers(String query) async {
    if (query.isEmpty) return [];
    try {
      final queryLower = query.toLowerCase();
      // Supabase full-text / ilike search across name, number, address
      final rows = await _client
          .from('customers')
          .select('id, name, phone, address, ro_type, customer_id')
          .or('name.ilike.%$queryLower%,phone.ilike.%$queryLower%,address.ilike.%$queryLower%,customer_id.ilike.%$queryLower%')
          .limit(10);

      return (rows as List<dynamic>)
          .map((r) => Map<String, dynamic>.from(r as Map))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  String _generateId() =>
      DateTime.now().millisecondsSinceEpoch.toRadixString(36) +
      DateTime.now().microsecond.toRadixString(36).padLeft(4, '0');
}
