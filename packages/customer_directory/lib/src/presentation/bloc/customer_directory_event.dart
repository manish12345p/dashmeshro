import '../../domain/entities/customer.dart';

abstract class CustomerDirectoryEvent {
  const CustomerDirectoryEvent();
}

class LoadCustomers extends CustomerDirectoryEvent {
  const LoadCustomers();
}

class UpdateCustomersList extends CustomerDirectoryEvent {
  final List<Customer> customers;
  const UpdateCustomersList(this.customers);
}

class SearchCustomers extends CustomerDirectoryEvent {
  final String query;
  const SearchCustomers(this.query);
}

class LoadCustomersError extends CustomerDirectoryEvent {
  final String error;
  const LoadCustomersError(this.error);
}

