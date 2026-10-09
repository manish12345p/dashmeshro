import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../packages/emi_page/lib/src/data/datasources/supabase_emi_remote_data_source.dart';

void main() async {
  final file = File('.env');
  final lines = await file.readAsLines();
  String url = '';
  String key = '';
  for (var line in lines) {
    if (line.startsWith('SUPABASE_URL=')) url = line.split('=')[1];
    if (line.startsWith('SUPABASE_ANON_KEY=')) key = line.split('=')[1];
  }
  
  await Supabase.initialize(url: url, anonKey: key);
  final ds = SupabaseEmiRemoteDataSource();
  try {
    final data = await ds.getEmiDashboardData();
    print('SUCCESS! Active installments: ${data.activeInstallments.length}');
  } catch (e, stack) {
    print('ERROR: $e');
    print(stack);
  }
  exit(0);
}
