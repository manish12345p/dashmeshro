import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_home_data_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUseCase _getHomeDataUseCase;

  HomeBloc({required GetHomeDataUseCase getHomeDataUseCase})
    : _getHomeDataUseCase = getHomeDataUseCase,
      super(const HomeState.initial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<FilterComplaints>(_onFilterComplaints);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());
    try {
      await emit.forEach(
        _getHomeDataUseCase(),
        onData: (data) {
          final currentFilter = state is HomeLoaded
              ? (state as HomeLoaded).filter
              : 'All';
          return HomeState.loaded(data: data, filter: currentFilter);
        },
        onError: (error, stackTrace) =>
            HomeState.error(message: error.toString()),
      );
    } catch (e) {
      emit(HomeState.error(message: e.toString()));
    }
  }

  void _onFilterComplaints(FilterComplaints event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(filter: event.filter));
    }
  }
}
