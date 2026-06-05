import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/home_data.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;
  const factory HomeState.loading() = HomeLoading;
  const factory HomeState.loaded({
    required HomeData data,
    @Default('All') String filter,
  }) = HomeLoaded;
  const factory HomeState.error({required String message}) = HomeError;
}
