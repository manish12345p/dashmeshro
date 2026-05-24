import 'dart:async';
import '../entities/home_data.dart';
import '../repositories/home_repository_interface.dart';

class GetHomeDataUseCase {
  final IHomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Stream<HomeData> call() {
    return repository.getHomeData();
  }
}
