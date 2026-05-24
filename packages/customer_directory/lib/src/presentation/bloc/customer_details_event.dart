import '../../domain/entities/customer.dart';

abstract class CustomerDetailsEvent {
  const CustomerDetailsEvent();
}

class LoadCustomerDetails extends CustomerDetailsEvent {
  final String id;
  const LoadCustomerDetails(this.id);
}

class UpdateCustomerDetails extends CustomerDetailsEvent {
  final Customer customer;
  const UpdateCustomerDetails(this.customer);
}
