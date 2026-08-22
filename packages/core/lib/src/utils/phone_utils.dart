class PhoneUtils {
  /// Parses a comma-separated phone string and returns a list of valid 10-digit numbers.
  static List<String> parsePhoneNumbers(String rawNumbers) {
    if (rawNumbers.trim().isEmpty) return [];

    final validNumbers = <String>[];
    
    // Split by any character that is NOT a digit or '+'
    final parts = rawNumbers.split(RegExp(r'[^\d+]+'));
    String currentBuffer = '';

    for (var part in parts) {
      final cleanPart = part.replaceAll(RegExp(r'[^0-9]'), '');
      if (cleanPart.isEmpty) continue;

      currentBuffer += cleanPart;
      
      while (currentBuffer.length >= 10) {
        int numLength = 10;
        
        // Handle common country codes +91 or 0
        if (currentBuffer.startsWith('91') && currentBuffer.length >= 12) {
          numLength = 12;
        } else if (currentBuffer.startsWith('0') && currentBuffer.length >= 11) {
          numLength = 11;
        }

        final numberBlock = currentBuffer.substring(0, numLength);
        final last10 = numberBlock.substring(numberBlock.length - 10);
        
        if (!validNumbers.contains(last10)) {
          validNumbers.add(last10);
        }
        
        currentBuffer = currentBuffer.substring(numLength);
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
