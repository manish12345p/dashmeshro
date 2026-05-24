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
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());
    try {
      await emit.forEach(
        _getHomeDataUseCase(),
        onData: (data) => HomeState.loaded(data: data),
        onError: (error, stackTrace) => HomeState.error(message: error.toString()),
      );
    } catch (e) {
      emit(HomeState.error(message: e.toString()));
    }
  }
}
