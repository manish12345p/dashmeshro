import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_emi_dashboard_data_usecase.dart';
import '../../domain/use_cases/mark_emi_paid_usecase.dart';
import '../../domain/use_cases/add_emi_payment_usecase.dart';
import '../../domain/use_cases/get_payment_history_usecase.dart';
import 'emi_event.dart';
import 'emi_state.dart';

class EmiBloc extends Bloc<EmiEvent, EmiState> {
  final GetEmiDashboardDataUseCase _getEmiDashboardDataUseCase;
  final MarkEmiPaidUseCase _markEmiPaidUseCase;
  final AddEmiPaymentUseCase _addEmiPaymentUseCase;
  final GetPaymentHistoryUseCase _getPaymentHistoryUseCase;

  EmiBloc(
    this._getEmiDashboardDataUseCase,
    this._markEmiPaidUseCase,
    this._addEmiPaymentUseCase,
    this._getPaymentHistoryUseCase,
  ) : super(EmiState.initial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<FilterInstallments>(_onFilterInstallments);
    on<SearchInstallments>(_onSearchInstallments);
    on<RemindCustomer>(_onRemindCustomer);
    on<MarkAsPaid>(_onMarkAsPaid);
    on<AddPayment>(_onAddPayment);
    on<LoadPaymentHistory>(_onLoadPaymentHistory);
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

  void _onSearchInstallments(SearchInstallments event, Emitter<EmiState> emit) {
    emit(state.copyWith(searchQuery: event.query));
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
      await _addEmiPaymentUseCase(
        event.installmentId,
        event.amount,
        paymentMethod: event.paymentMethod,
        transactionRef: event.transactionRef,
        notes: event.notes,
        recordedBy: event.recordedBy,
      );
      // Reload dashboard to reflect the payment
      add(const LoadDashboard());
      add(const LoadPaymentHistory());
    } catch (e) {
      emit(
        state.copyWith(
          status: EmiStatus.failure,
          errorMessage: 'Failed to add payment: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onLoadPaymentHistory(
    LoadPaymentHistory event,
    Emitter<EmiState> emit,
  ) async {
    try {
      final history = await _getPaymentHistoryUseCase();
      emit(state.copyWith(paymentHistory: history));
    } catch (e) {
      // Don't change main status to failure, just log or ignore
      // Optional: Handle error for history explicitly
    }
  }
}
