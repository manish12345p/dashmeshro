import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExpenseDatabase {
  static Database? _database;
  static const String _tableName = 'expenses';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            reason TEXT NOT NULL,
            amount REAL NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  /// Add a new expense entry
  static Future<void> addExpense(String reason, double amount) async {
    final db = await database;
    await db.insert(_tableName, {
      'reason': reason,
      'amount': amount,
      'created_at': DateTime.now().toIso8601String(),
    });
    // Clean up old entries
    await _deleteOldEntries();
  }

  /// Get all expenses (newest first), auto-deleting entries older than 15 days
  static Future<List<Map<String, dynamic>>> getExpenses() async {
    final db = await database;
    await _deleteOldEntries();
    return await db.query(
      _tableName,
      orderBy: 'created_at DESC',
    );
  }

  /// Delete entries older than 15 days
  static Future<void> _deleteOldEntries() async {
    final db = await database;
    final cutoff = DateTime.now().subtract(const Duration(days: 15)).toIso8601String();
    await db.delete(
      _tableName,
      where: 'created_at < ?',
      whereArgs: [cutoff],
    );
  }

  /// Delete a single expense
  static Future<void> deleteExpense(int id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
