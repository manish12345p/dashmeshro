import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  testWidgets('Test DB', (WidgetTester tester) async {
    final supabase = SupabaseClient('https://wietkmauaxskcnbnqbck.supabase.co', 'sb_publishable_z5IKh_iK-AoUdLrcKitLHw_C_0gH8OB');
    final data = await supabase.from('payments').select().limit(5);
    print(data);
  });
}
