import 'package:flutter_test/flutter_test.dart';
import 'package:customer_directory/customer_directory.dart';

void main() {
  group('Customer Model Tests', () {
    test('should correctly deserialize from json', () {
      final json = {
        'id': 'test_id',
        'name': 'Test Customer',
        'customer_id': 'MCP-999',
        'number': '+91 99999 99999',
        'address': '123, Test Street, Test City',
        'locality': 'Test Locality',
        'ro_type': 'Kent',
        'note': 'Test Note',
        'service_history': [
          {
            'id': 'test_service',
            'serviceType': 'Maintenance',
            'fixes': 'Filter checked',
            'totalAmount': 500.0,
            'amountPaid': 500.0,
            'equipmentsUsed': 'Wrench',
            'serviceDate': '2024-02-20T00:00:00.000',
            'guaranteeDuration': '',
            'remarks': '',
          },
        ],
      };

      final customer = Customer.fromJson(json);

      expect(customer.id, 'test_id');
      expect(customer.name, 'Test Customer');
      expect(customer.customerId, 'MCP-999');
      expect(customer.number, '+91 99999 99999');
      expect(customer.serviceHistory.length, 1);
      expect(customer.serviceHistory.first.fixes, 'Filter checked');
    });

    test('should correctly serialize to json', () {
      final customer = Customer(
        id: 'test_id',
        name: 'Test Customer',
        customerId: 'MCP-999',
        number: '+91 99999 99999',
        address: '123, Test Street, Test City',
        locality: 'Test Locality',
        roType: 'Kent',
        note: 'Test Note',
        isDeleted: false,
        serviceHistory: [
          ServiceActivity(
            id: 'test_service',
            serviceType: 'Maintenance',
            fixes: 'Filter checked',
            totalAmount: 500.0,
            amountPaid: 500.0,
            equipmentsUsed: 'Wrench',
            serviceDate: DateTime.parse('2024-02-20T00:00:00.000'),
            guaranteeDuration: '',
            remarks: '',
          ),
        ],
      );

      final json = customer.toJson();

      expect(json['id'], 'test_id');
      expect(json['name'], 'Test Customer');
      expect(json['customer_id'], 'MCP-999');
      expect(json['service_history'].length, 1);
      expect(json['service_history'][0]['fixes'], 'Filter checked');
    });
  });
}
