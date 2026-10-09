import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  print('Testing Supabase Connection...');

  final supabase = SupabaseClient(
    'https://wietkmauaxskcnbnqbck.supabase.co',
    'sb_publishable_z5IKh_iK-AoUdLrcKitLHw_C_0gH8OB',
  );

  print('1. Testing customers table (Limit 1)');
  try {
    final customers = await supabase.from('customers').select('*').limit(1);
    print('✅ Customers table successful! Response: $customers');
  } catch (e) {
    print('❌ Error fetching customers: $e');
  }

  print('\n2. Testing ro_types table');
  try {
    final roTypes = await supabase.from('ro_types').select('name');
    print('✅ RO Types table successful! Response: $roTypes');
  } catch (e) {
    print('❌ Error fetching ro_types: $e');
  }

  print('\n3. Testing services table (Limit 1)');
  try {
    final services = await supabase.from('services').select('*').limit(1);
    print('✅ Services table successful! Response: $services');
  } catch (e) {
    print('❌ Error fetching services: $e');
  }
}
