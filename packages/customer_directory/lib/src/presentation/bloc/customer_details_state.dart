import '../../domain/entities/customer.dart';

abstract class CustomerDetailsState {
  const CustomerDetailsState();
}

class CustomerDetailsInitial extends CustomerDetailsState {
  const CustomerDetailsInitial();
}

class CustomerDetailsLoading extends CustomerDetailsState {
  const CustomerDetailsLoading();
}

class CustomerDetailsLoaded extends CustomerDetailsState {
  final Customer customer;
  const CustomerDetailsLoaded(this.customer);
}

class CustomerDetailsError extends CustomerDetailsState {
  final String message;
  const CustomerDetailsError(this.message);
}
