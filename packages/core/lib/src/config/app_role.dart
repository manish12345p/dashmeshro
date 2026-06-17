import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppRole {
  technician,
  admin,
}

class RoleCubit extends Cubit<AppRole> {
  static const String _roleKey = 'dashmeshro_user_role';
  final SharedPreferences _prefs;

  RoleCubit(this._prefs) : super(_loadInitialRole(_prefs));

  static AppRole _loadInitialRole(SharedPreferences prefs) {
    final storedRole = prefs.getString(_roleKey);
    if (storedRole == AppRole.admin.name) {
      return AppRole.admin;
    }
    return AppRole.admin;
  }

  bool unlockAdmin(String password) {
    // Exact password logic. Case sensitive.
    // Tries to get from .env, falls back to the exact string provided.
    final expectedPassword = dotenv.env['ADMIN_PASSWORD'] ?? "Admin-kalkaji-TA@2045";
    
    if (password == expectedPassword) {
      _prefs.setString(_roleKey, AppRole.admin.name);
      emit(AppRole.admin);
      return true;
    }
    return false;
  }

  void revokeAdmin() {
    _prefs.setString(_roleKey, AppRole.technician.name);
    emit(AppRole.technician);
  }
}
