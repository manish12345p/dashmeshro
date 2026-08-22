class ServiceDetailsFormatter {
  static String format({
    required String header,
    required String customerName,
    required String phone,
    required String address,
    required String serviceType,
    required String date,
    String note = '',
  }) {
    return '''*$header*
Customer: $customerName
Phone: $phone
Address: $address
Service: $serviceType
Date: $date
${note.isNotEmpty ? 'Note: $note' : ''}''';
  }
}
