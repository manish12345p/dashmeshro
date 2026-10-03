import '../../domain/entities/home_data.dart';

abstract class IHomeRemoteDataSource {
  Stream<HomeData> getHomeData();
  Future<void> createHomeData(HomeData data);
  Future<void> updateHomeData(HomeData data);
  Future<void> deleteHomeData(String id);
}
