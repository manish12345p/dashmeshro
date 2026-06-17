import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_all_services_usecase.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetAllServicesUseCase _getAllServicesUseCase;
  StreamSubscription? _servicesSubscription;

  HistoryBloc({
    required GetAllServicesUseCase getAllServicesUseCase,
  })  : _getAllServicesUseCase = getAllServicesUseCase,
        super(HistoryState.initial()) {
    on<LoadHistory>(_onLoadHistory);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<FilterByServiceType>(_onFilterByServiceType);
  }

  Future<void> _onLoadHistory(
    LoadHistory event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await _servicesSubscription?.cancel();

    final completer = Completer<void>();
    _servicesSubscription = _getAllServicesUseCase.execute().listen(
      (services) {
        emit(
          state.copyWith(
            isLoading: false,
            allServices: services,
            errorMessage: null,
          ),
        );
        if (!completer.isCompleted) completer.complete();
      },
      onError: (error) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
        if (!completer.isCompleted) completer.completeError(error);
      },
    );

    try {
      await completer.future;
    } catch (_) {}
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<HistoryState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onFilterByServiceType(
    FilterByServiceType event,
    Emitter<HistoryState> emit,
  ) {
    emit(state.copyWith(selectedServiceType: event.type));
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
