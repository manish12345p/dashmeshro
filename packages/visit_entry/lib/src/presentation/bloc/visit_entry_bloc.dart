import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/save_visit_usecase.dart';
import '../../domain/entities/visit_record.dart';
import 'visit_entry_event.dart';

enum VisitEntryStatus { initial, submitting, success, failure }

class VisitEntryState {
  final VisitEntryStatus status;
  final String? errorMessage;

  // Form fields
  final String? customerId;
  final String? customerName;
  final String serviceType;
  final bool isUrgent;
  final String remarks;
  final String fixes;
  final double amountPaid;
  final double amountPending;
  final double totalAmount;
  final double? emiAmountPerMonth;
  final String equipmentsUsed;
  final String serviceDuration;
  final String guaranteeDuration;
  final bool isComplaint;
  final String? serviceDate;
  final int remainingAmcVisits;
  final int totalAmcVisitsToPurchase;

  const VisitEntryState({
    this.status = VisitEntryStatus.initial,
    this.errorMessage,
    this.customerId,
    this.customerName,
    this.serviceType = '',
    this.isUrgent = false,
    this.remarks = '',
    this.fixes = '',
    this.amountPaid = 0.0,
    this.amountPending = 0.0,
    this.totalAmount = 0.0,
    this.emiAmountPerMonth = 500.0,
    this.equipmentsUsed = '',
    this.serviceDuration = '',
    this.guaranteeDuration = '',
    this.isComplaint = false,
    this.serviceDate,
    this.remainingAmcVisits = 0,
    this.totalAmcVisitsToPurchase = 0,
  });

  // Helper to ensure serviceDate defaults to today if not provided
  String get effectiveServiceDate =>
      serviceDate ?? DateTime.now().toIso8601String().split('T')[0];

  VisitEntryState copyWith({
    VisitEntryStatus? status,
    String? errorMessage,
    String? customerId,
    String? customerName,
    String? serviceType,
    bool? isUrgent,
    String? remarks,
    String? fixes,
    double? amountPaid,
    double? amountPending,
    double? totalAmount,
    double? emiAmountPerMonth,
    String? equipmentsUsed,
    String? serviceDuration,
    String? guaranteeDuration,
    bool? isComplaint,
    String? serviceDate,
    int? remainingAmcVisits,
    int? totalAmcVisitsToPurchase,
  }) {
    return VisitEntryState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      serviceType: serviceType ?? this.serviceType,
      isUrgent: isUrgent ?? this.isUrgent,
      remarks: remarks ?? this.remarks,
      fixes: fixes ?? this.fixes,
      amountPaid: amountPaid ?? this.amountPaid,
      amountPending: amountPending ?? this.amountPending,
      totalAmount: totalAmount ?? this.totalAmount,
      emiAmountPerMonth: emiAmountPerMonth == null
          ? this.emiAmountPerMonth
          : (emiAmountPerMonth == 0 ? null : emiAmountPerMonth),
      equipmentsUsed: equipmentsUsed ?? this.equipmentsUsed,
      serviceDuration: serviceDuration ?? this.serviceDuration,
      guaranteeDuration: guaranteeDuration ?? this.guaranteeDuration,
      isComplaint: isComplaint ?? this.isComplaint,
      serviceDate: serviceDate ?? this.serviceDate,
      remainingAmcVisits: remainingAmcVisits ?? this.remainingAmcVisits,
      totalAmcVisitsToPurchase: totalAmcVisitsToPurchase ?? this.totalAmcVisitsToPurchase,
    );
  }
}

class VisitEntryBloc extends Bloc<VisitEntryEvent, VisitEntryState> {
  final SaveServiceUseCase _saveServiceUseCase;

  VisitEntryBloc(
    this._saveServiceUseCase, {
    String? initialCustomerId,
    String? initialCustomerName,
    int? initialRemainingAmcVisits,
  }) : super(
         VisitEntryState(
           customerId: initialCustomerId,
           customerName: initialCustomerName,
           remainingAmcVisits: initialRemainingAmcVisits ?? 0,
         ),
       ) {
    on<SelectCustomer>(_onSelectCustomer);
    on<SelectServiceType>(_onSelectServiceType);
    on<ToggleUrgency>(_onToggleUrgency);
    on<ToggleComplaint>(_onToggleComplaint);
    on<UpdateTotalAmcVisitsToPurchase>(_onUpdateTotalAmcVisitsToPurchase);
    on<UpdateRemarks>(_onUpdateRemarks);
    on<UpdateFixes>(_onUpdateFixes);
    on<UpdateAmountPaid>(_onUpdateAmountPaid);
    on<UpdateAmountPending>(_onUpdateAmountPending);
    on<UpdateTotalAmount>(_onUpdateTotalAmount);
    on<UpdateEquipmentsUsed>(_onUpdateEquipmentsUsed);
    on<UpdateServiceDuration>(_onUpdateServiceDuration);
    on<UpdateGuaranteeDuration>(_onUpdateGuaranteeDuration);
    on<UpdateEmiAmountPerMonth>(_onUpdateEmiAmountPerMonth);
    on<SetDate>(_onSetDate);
    on<SubmitVisitEntry>(_onSubmit);
  }

  void _onUpdateTotalAmcVisitsToPurchase(
    UpdateTotalAmcVisitsToPurchase event,
    Emitter<VisitEntryState> emit,
  ) {
    emit(state.copyWith(totalAmcVisitsToPurchase: event.visits));
  }

  void _onSelectCustomer(SelectCustomer event, Emitter<VisitEntryState> emit) {
    emit(state.copyWith(
      customerId: event.id,
      customerName: event.name,
      remainingAmcVisits: event.remainingAmcVisits,
    ));
  }

  void _onSelectServiceType(
    SelectServiceType event,
    Emitter<VisitEntryState> emit,
  ) {
    emit(state.copyWith(serviceType: event.type));
  }

  void _onToggleUrgency(ToggleUrgency event, Emitter<VisitEntryState> emit) {
    emit(state.copyWith(isUrgent: event.isUrgent));
  }

  void _onToggleComplaint(ToggleComplaint event, Emitter<VisitEntryState> emit) {
    emit(state.copyWith(isComplaint: event.isComplaint));
  }

  void _onUpdateRemarks(UpdateRemarks event, Emitter<VisitEntryState> emit) {
    emit(state.copyWith(remarks: event.remarks));
  }

  void _onUpdateFixes(UpdateFixes event, Emitter<VisitEntryState> emit) {
    emit(state.copyWith(fixes: event.fixes));
  }

  void _onUpdateAmountPaid(
    UpdateAmountPaid event,
    Emitter<VisitEntryState> emit,
  ) {
    double pending = state.totalAmount - event.amount;
    if (pending < 0) pending = 0;
    emit(state.copyWith(amountPaid: event.amount, amountPending: pending));
  }

  void _onUpdateAmountPending(
    UpdateAmountPending event,
    Emitter<VisitEntryState> emit,
  ) {
    double paid = state.totalAmount - event.amount;
    if (paid < 0) paid = 0;
    emit(state.copyWith(amountPending: event.amount, amountPaid: paid));
  }

  void _onUpdateTotalAmount(
    UpdateTotalAmount event,
    Emitter<VisitEntryState> emit,
  ) {
    double pending = event.amount - state.amountPaid;
    if (pending < 0) pending = 0;
    emit(state.copyWith(totalAmount: event.amount, amountPending: pending));
  }

  void _onUpdateEquipmentsUsed(
    UpdateEquipmentsUsed event,
    Emitter<VisitEntryState> emit,
  ) {
    emit(state.copyWith(equipmentsUsed: event.equipments));
  }

  void _onUpdateServiceDuration(
    UpdateServiceDuration event,
    Emitter<VisitEntryState> emit,
  ) {
    emit(state.copyWith(serviceDuration: event.duration));
  }

  void _onUpdateGuaranteeDuration(
    UpdateGuaranteeDuration event,
    Emitter<VisitEntryState> emit,
  ) {
    emit(state.copyWith(guaranteeDuration: event.duration));
  }

  void _onUpdateEmiAmountPerMonth(
    UpdateEmiAmountPerMonth event,
    Emitter<VisitEntryState> emit,
  ) {
    emit(state.copyWith(emiAmountPerMonth: event.amount ?? 0.0));
  }

  void _onSetDate(SetDate event, Emitter<VisitEntryState> emit) {
    emit(state.copyWith(serviceDate: event.date));
  }

  Future<void> _onSubmit(
    SubmitVisitEntry event,
    Emitter<VisitEntryState> emit,
  ) async {
    if (state.customerId == null || state.customerId!.isEmpty) {
      emit(
        state.copyWith(
          status: VisitEntryStatus.failure,
          errorMessage: 'Please select a customer',
        ),
      );
      emit(state.copyWith(status: VisitEntryStatus.initial));
      return;
    }

    // No service type validation needed

    // Service Duration is no longer mandatory

    if (state.amountPaid + state.amountPending > state.totalAmount) {
      emit(
        state.copyWith(
          status: VisitEntryStatus.failure,
          errorMessage:
              'Paid Amount + Pending Amount cannot exceed Total Amount. Please check your entries.',
        ),
      );
      emit(state.copyWith(status: VisitEntryStatus.initial));
      return;
    }

    emit(state.copyWith(status: VisitEntryStatus.submitting));

    try {
      final entry = VisitRecord(
        id: 'SE-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
        customerId: state.customerId!,
        serviceType: state.serviceType,
        isUrgent: state.isUrgent,
        isComplaint: state.isComplaint,
        serviceDate:
            DateTime.tryParse(state.effectiveServiceDate) ?? DateTime.now(),
        remarks: state.remarks,
        fixes: state.fixes,
        amountPaid: state.amountPaid,
        amountPending: state.amountPending,
        totalAmount: state.totalAmount,
        equipmentsUsed: state.equipmentsUsed,
        serviceDuration: state.serviceDuration,
        guaranteeDuration: state.guaranteeDuration,
      );

      await _saveServiceUseCase(
        entry,
        emiAmountPerMonth: state.emiAmountPerMonth,
        totalAmcVisitsToPurchase: state.serviceType == 'AMC' && state.remainingAmcVisits <= 0
            ? state.totalAmcVisitsToPurchase
            : null,
      );
      emit(const VisitEntryState(status: VisitEntryStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: VisitEntryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
