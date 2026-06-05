import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/customer.dart';
import '../../domain/use_cases/get_customers_usecase.dart';
import 'customer_directory_event.dart';
import 'customer_directory_state.dart';

class CustomerDirectoryBloc
    extends Bloc<CustomerDirectoryEvent, CustomerDirectoryState> {
  final GetCustomersUseCase _getCustomersUseCase;
  StreamSubscription? _subscription;

  CustomerDirectoryBloc({required GetCustomersUseCase getCustomersUseCase})
    : _getCustomersUseCase = getCustomersUseCase,
      super(const CustomerDirectoryInitial()) {
    on<LoadCustomers>(_onLoadCustomers);
    on<UpdateCustomersList>(_onUpdateCustomersList);
    on<SearchCustomers>(_onSearchCustomers);
    on<LoadCustomersError>(_onLoadCustomersError);
  }

  void _onLoadCustomers(
    LoadCustomers event,
    Emitter<CustomerDirectoryState> emit,
  ) {
    emit(const CustomerDirectoryLoading());
    _subscription?.cancel();
    _subscription = _getCustomersUseCase().listen(
      (customers) => add(UpdateCustomersList(customers)),
      onError: (error) => add(LoadCustomersError(error.toString())),
    );
  }

  void _onLoadCustomersError(
    LoadCustomersError event,
    Emitter<CustomerDirectoryState> emit,
  ) {
    emit(CustomerDirectoryError(event.error));
  }

  void _onUpdateCustomersList(
    UpdateCustomersList event,
    Emitter<CustomerDirectoryState> emit,
  ) {
    String currentQuery = '';
    if (state is CustomerDirectoryLoaded) {
      currentQuery = (state as CustomerDirectoryLoaded).searchQuery;
    }

    final filtered = _filterCustomers(event.customers, currentQuery);
    emit(
      CustomerDirectoryLoaded(
        allCustomers: event.customers,
        filteredCustomers: filtered,
        searchQuery: currentQuery,
      ),
    );
  }

  void _onSearchCustomers(
    SearchCustomers event,
    Emitter<CustomerDirectoryState> emit,
  ) {
    if (state is CustomerDirectoryLoaded) {
      final loaded = state as CustomerDirectoryLoaded;
      final filtered = _filterCustomers(loaded.allCustomers, event.query);
      emit(
        loaded.copyWith(filteredCustomers: filtered, searchQuery: event.query),
      );
    }
  }

  List<Customer> _filterCustomers(List<Customer> customers, String query) {
    if (query.isEmpty) return customers;
    final lowercaseQuery = query.toLowerCase();
    return customers.where((c) {
      return c.name.toLowerCase().contains(lowercaseQuery) ||
          c.customerId.toLowerCase().contains(lowercaseQuery) ||
          c.locality.toLowerCase().contains(lowercaseQuery) ||
          c.roType.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
