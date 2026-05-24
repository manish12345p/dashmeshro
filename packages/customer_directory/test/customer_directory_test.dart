import 'package:flutter_test/flutter_test.dart';
import 'package:customer_directory/customer_directory.dart';

void main() {
  group('Customer Model Tests', () {
    test('should correctly deserialize from map', () {
      final map = {
        'id': 'test_id',
        'name': 'Test Customer',
        'customer_id': 'MCP-999',
        'number': '+91 99999 99999',
        'email': 'test@customer.com',
        'address': '123, Test Street, Test City',
        'locality': 'Test Locality',
        'ro_type': 'Kent',
        'note': 'Test Note',
        'role': 'Owner',
        'status': 'active',
        'customer_type': 'Active AMC',
        'avatar_url': 'http://avatar.url',
        'device_name': 'Aqua Test',
        'device_installed_on': '10 Jan 2024',
        'device_last_service': '20 Feb 2024',
        'device_filter_health': 0.85,
        'total_visits': 5,
        'active_amc': true,
        'customer_value': '10k',
        'open_tickets': 1,
        'service_history': [
          {
            'activityType': 'maintenance',
            'title': 'Regular Check',
            'description': 'Filter checked',
            'technicianName': 'John',
            'dateText': '20 Feb 2024',
            'statusBadge': 'healthy',
          }
        ]
      };

      final customer = Customer.fromMap(map, documentId: 'test_id');

      expect(customer.id, 'test_id');
      expect(customer.name, 'Test Customer');
      expect(customer.customerId, 'MCP-999');
      expect(customer.number, '+91 99999 99999');
      expect(customer.email, 'test@customer.com');
      expect(customer.deviceFilterHealth, 0.85);
      expect(customer.serviceHistory.length, 1);
      expect(customer.serviceHistory.first.title, 'Regular Check');
    });

    test('should correctly serialize to map', () {
      const customer = Customer(
        id: 'test_id',
        name: 'Test Customer',
        customerId: 'MCP-999',
        number: '+91 99999 99999',
        email: 'test@customer.com',
        address: '123, Test Street, Test City',
        locality: 'Test Locality',
        roType: 'Kent',
        note: 'Test Note',
        role: 'Owner',
        status: 'active',
        customerType: 'Active AMC',
        avatarUrl: 'http://avatar.url',
        deviceName: 'Aqua Test',
        deviceInstalledOn: '10 Jan 2024',
        deviceLastService: '20 Feb 2024',
        deviceFilterHealth: 0.85,
        totalVisits: 5,
        activeAmc: true,
        customerValue: '10k',
        openTickets: 1,
        serviceHistory: [
          ServiceActivity(
            activityType: 'maintenance',
            title: 'Regular Check',
            description: 'Filter checked',
            technicianName: 'John',
            dateText: '20 Feb 2024',
            statusBadge: 'healthy',
          )
        ],
      );

      final map = customer.toMap();

      expect(map['id'], 'test_id');
      expect(map['name'], 'Test Customer');
      expect(map['customer_id'], 'MCP-999');
      expect(map['device_filter_health'], 0.85);
      expect(map['service_history'].length, 1);
      expect(map['service_history'][0]['title'], 'Regular Check');
    });
  });

  group('CustomerRepository Tests', () {
    test('should stream mock list when Firebase is uninitialized', () async {
      final repository = CustomerRepository();
      final customers = await repository.getCustomers().first;

      expect(customers.isNotEmpty, true);
      expect(customers.any((c) => c.name == 'Vikram Rathore'), true);
    });

    test('should stream mock customer details when Firebase is uninitialized', () async {
      final repository = CustomerRepository();
      final customer = await repository.getCustomerById('vikram_rathore').first;

      expect(customer.id, 'vikram_rathore');
      expect(customer.name, 'Vikram Rathore');
    });
  });
}
