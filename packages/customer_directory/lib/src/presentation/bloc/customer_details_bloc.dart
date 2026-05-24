import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_customer_by_id_usecase.dart';
import 'customer_details_event.dart';
import 'customer_details_state.dart';

class CustomerDetailsBloc extends Bloc<CustomerDetailsEvent, CustomerDetailsState> {
  final GetCustomerByIdUseCase _getCustomerByIdUseCase;
  StreamSubscription? _subscription;

  CustomerDetailsBloc({
    required GetCustomerByIdUseCase getCustomerByIdUseCase,
  })  : _getCustomerByIdUseCase = getCustomerByIdUseCase,
        super(const CustomerDetailsInitial()) {
    on<LoadCustomerDetails>(_onLoadCustomerDetails);
    on<UpdateCustomerDetails>(_onUpdateCustomerDetails);
    on<LoadCustomerDetailsError>(_onLoadCustomerDetailsError);
  }

  void _onLoadCustomerDetails(LoadCustomerDetails event, Emitter<CustomerDetailsState> emit) {
    emit(const CustomerDetailsLoading());
    _subscription?.cancel();
    _subscription = _getCustomerByIdUseCase(event.id).listen(
      (customer) => add(UpdateCustomerDetails(customer)),
      onError: (error) => add(LoadCustomerDetailsError(error.toString())),
    );
  }

  void _onLoadCustomerDetailsError(LoadCustomerDetailsError event, Emitter<CustomerDetailsState> emit) {
    emit(CustomerDetailsError(event.error));
  }

  void _onUpdateCustomerDetails(UpdateCustomerDetails event, Emitter<CustomerDetailsState> emit) {
    emit(CustomerDetailsLoaded(event.customer));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
