import 'dart:async';
import '../../domain/entities/home_data.dart';
import '../../domain/repositories/home_repository_interface.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepository implements IHomeRepository {
  final IHomeRemoteDataSource remoteDataSource;

  HomeRepository({required this.remoteDataSource});

  @override
  Stream<HomeData> getHomeData() {
    return remoteDataSource.getHomeData();
  }

  @override
  Future<void> createHomeData(HomeData data) {
    return remoteDataSource.createHomeData(data);
  }

  @override
  Future<void> updateHomeData(HomeData data) {
    return remoteDataSource.updateHomeData(data);
  }

  @override
  Future<void> deleteHomeData(String id) {
    return remoteDataSource.deleteHomeData(id);
  }
}
