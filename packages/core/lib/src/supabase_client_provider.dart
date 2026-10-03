import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provides a configured [SupabaseClient] initialized from environment variables.
///
/// Call [SupabaseClientProvider.initialize()] once in your app startup
/// (e.g. main.dart before runApp) before accessing [SupabaseClientProvider.client].
class SupabaseClientProvider {
  SupabaseClientProvider._();

  static SupabaseClient? _client;

  /// Returns the initialized [SupabaseClient].
  /// Throws [StateError] if [initialize] has not been called yet.
  static SupabaseClient get client {
    if (_client != null) return _client!;
    // Supabase.instance.client is set after Supabase.initialize() completes.
    return Supabase.instance.client;
  }

  /// Initializes the Supabase SDK using URL and anon key from the `.env` file.
  ///
  /// Must be called after `await dotenv.load(...)`.
  static Future<void> initialize() async {
    final url = dotenv.env['SUPABASE_URL'] ?? '';
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

    if (url.isEmpty || anonKey.isEmpty) {
      throw StateError(
        'SUPABASE_URL and SUPABASE_ANON_KEY must be set in your .env file.',
      );
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
    _client = Supabase.instance.client;
  }
}
