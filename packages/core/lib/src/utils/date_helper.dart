import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateHelper {
  /// Converts a dynamic value (String, Timestamp, or DateTime) to a DateTime
  static DateTime? toDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Returns the current DateTime as a Firestore Timestamp
  static Timestamp nowTimestamp() {
    return Timestamp.now();
  }

  /// Converts a DateTime to a String in mm/dd/yyyy format
  static String format(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MM/dd/yyyy').format(date);
  }
}
