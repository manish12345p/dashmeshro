import '../../domain/entities/customer.dart';

abstract class CustomerDirectoryState {
  const CustomerDirectoryState();
}

class CustomerDirectoryInitial extends CustomerDirectoryState {
  const CustomerDirectoryInitial();
}

class CustomerDirectoryLoading extends CustomerDirectoryState {
  const CustomerDirectoryLoading();
}

class CustomerDirectoryLoaded extends CustomerDirectoryState {
  final List<Customer> allCustomers;
  final List<Customer> filteredCustomers;
  final String searchQuery;

  const CustomerDirectoryLoaded({
    required this.allCustomers,
    required this.filteredCustomers,
    required this.searchQuery,
  });

  CustomerDirectoryLoaded copyWith({
    List<Customer>? allCustomers,
    List<Customer>? filteredCustomers,
    String? searchQuery,
  }) {
    return CustomerDirectoryLoaded(
      allCustomers: allCustomers ?? this.allCustomers,
      filteredCustomers: filteredCustomers ?? this.filteredCustomers,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class CustomerDirectoryError extends CustomerDirectoryState {
  final String message;
  const CustomerDirectoryError(this.message);
}
