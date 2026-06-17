import 'package:cloud_firestore/cloud_firestore.dart';

/// Model representing a customer note/record
class NoteModel {
  final String? id;
  final String name;
  final String phone;
  final String address;
  final String note;
  final double? price;
  final DateTime createdAt;

  const NoteModel({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.note,
    this.price,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'address': address,
        'note': note,
        'price': price,
        'created_at': createdAt.toIso8601String(),
      };

  factory NoteModel.fromMap(String id, Map<String, dynamic> map) => NoteModel(
        id: id,
        name: map['name'] as String? ?? '',
        phone: map['phone'] as String? ?? '',
        address: map['address'] as String? ?? '',
        note: map['note'] as String? ?? '',
        price: (map['price'] as num?)?.toDouble(),
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'] as String) ?? DateTime.now()
            : DateTime.now(),
      );
}

/// Firestore data source for notes (replaces SQLite ExpenseDatabase)
class NoteFirestore {
  static final _col = FirebaseFirestore.instance.collection('notes');

  /// Add a new note
  static Future<void> addNote(NoteModel note) async {
    await _col.add(note.toMap());
  }

  /// Get all notes ordered by newest first (one-time fetch)
  static Future<List<NoteModel>> getNotes() async {
    final snapshot =
        await _col.orderBy('created_at', descending: true).get();
    return snapshot.docs
        .map((doc) => NoteModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// Stream of all notes (real-time updates)
  static Stream<List<NoteModel>> watchNotes() {
    return _col
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => NoteModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  /// Delete a note by Firestore document ID
  static Future<void> deleteNote(String id) async {
    await _col.doc(id).delete();
  }
}
