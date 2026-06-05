import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_emi_dashboard_data_usecase.dart';
import '../../domain/use_cases/mark_emi_paid_usecase.dart';
import '../../domain/use_cases/add_emi_payment_usecase.dart';
import 'emi_event.dart';
import 'emi_state.dart';

class EmiBloc extends Bloc<EmiEvent, EmiState> {
  final GetEmiDashboardDataUseCase _getEmiDashboardDataUseCase;
  final MarkEmiPaidUseCase _markEmiPaidUseCase;
  final AddEmiPaymentUseCase _addEmiPaymentUseCase;

  EmiBloc(
    this._getEmiDashboardDataUseCase,
    this._markEmiPaidUseCase,
    this._addEmiPaymentUseCase,
  ) : super(EmiState.initial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<FilterInstallments>(_onFilterInstallments);
    on<RemindCustomer>(_onRemindCustomer);
    on<MarkAsPaid>(_onMarkAsPaid);
    on<AddPayment>(_onAddPayment);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<EmiState> emit,
  ) async {
    emit(state.copyWith(status: EmiStatus.loading));
    try {
      final data = await _getEmiDashboardDataUseCase();
      emit(state.copyWith(status: EmiStatus.success, data: data));
    } catch (e) {
      emit(
        state.copyWith(status: EmiStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void _onFilterInstallments(FilterInstallments event, Emitter<EmiState> emit) {
    emit(state.copyWith(selectedFilter: event.status));
  }

  void _onRemindCustomer(RemindCustomer event, Emitter<EmiState> emit) {
    // TODO: Implement remind logic (e.g. send WhatsApp/SMS)
  }

  Future<void> _onMarkAsPaid(MarkAsPaid event, Emitter<EmiState> emit) async {
    try {
      await _markEmiPaidUseCase(event.installmentId);
      // Reload to get fresh data after payment
      add(const LoadDashboard());
    } catch (e) {
      emit(
        state.copyWith(
          status: EmiStatus.failure,
          errorMessage: 'Failed to mark as paid: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onAddPayment(AddPayment event, Emitter<EmiState> emit) async {
    try {
      await _addEmiPaymentUseCase(event.installmentId, event.amount);
      // Reload dashboard to reflect the payment
      add(const LoadDashboard());
    } catch (e) {
      emit(
        state.copyWith(
          status: EmiStatus.failure,
          errorMessage: 'Failed to add payment: ${e.toString()}',
        ),
      );
    }
  }
}
