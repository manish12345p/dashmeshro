class PhoneUtils {
  /// Parses a comma-separated phone string and returns a list of valid 10-digit numbers.
  static List<String> parsePhoneNumbers(String rawNumbers) {
    if (rawNumbers.trim().isEmpty) return [];

    final parts = rawNumbers.split(',');
    final validNumbers = <String>[];

    for (var part in parts) {
      final cleanNum = part.replaceAll(RegExp(r'[^0-9]'), '');
      if (cleanNum.length >= 10) {
        // Just take the last 10 digits as standard Indian mobile
        final last10 = cleanNum.substring(cleanNum.length - 10);
        validNumbers.add(last10);
      }
    }
    return validNumbers;
  }

  /// Returns the first valid phone number as a WhatsApp-ready URL (with 91 prefix).
  static Uri? getWhatsAppUri(String rawNumbers) {
    final numbers = parsePhoneNumbers(rawNumbers);
    if (numbers.isEmpty) return null;
    return Uri.parse('https://wa.me/91${numbers.first}');
  }

  /// Returns the first valid phone number for calling.
  static Uri? getCallUri(String rawNumbers) {
    final numbers = parsePhoneNumbers(rawNumbers);
    if (numbers.isEmpty) return null;
    return Uri.parse('tel:${numbers.first}');
  }
}
