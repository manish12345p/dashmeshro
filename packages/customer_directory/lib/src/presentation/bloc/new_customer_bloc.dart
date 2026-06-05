import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository_interface.dart';

part 'new_customer_bloc.freezed.dart';

@freezed
class NewCustomerEvent with _$NewCustomerEvent {
  const factory NewCustomerEvent.submit({
    required Customer customer,
    @Default(false) bool navigateToService,
  }) = _Submit;
}

@freezed
class NewCustomerState with _$NewCustomerState {
  const factory NewCustomerState.initial() = _Initial;
  const factory NewCustomerState.submitting() = _Submitting;
  const factory NewCustomerState.success({
    required String docId,
    required String customerName,
    @Default(false) bool navigateToService,
  }) = _Success;
  const factory NewCustomerState.failure(String message) = _Failure;
}

class NewCustomerBloc extends Bloc<NewCustomerEvent, NewCustomerState> {
  final ICustomerRepository _repository;

  NewCustomerBloc(this._repository) : super(const NewCustomerState.initial()) {
    on<_Submit>(_onSubmit);
  }

  Future<void> _onSubmit(_Submit event, Emitter<NewCustomerState> emit) async {
    emit(const NewCustomerState.submitting());
    try {
      final docId = await _repository.createCustomer(event.customer);
      emit(NewCustomerState.success(
        docId: docId,
        customerName: event.customer.name,
        navigateToService: event.navigateToService,
      ));
    } catch (e) {
      emit(NewCustomerState.failure(e.toString()));
    }
  }
}
