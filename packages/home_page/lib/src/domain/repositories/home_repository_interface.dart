import 'dart:async';
import '../entities/home_data.dart';

abstract class IHomeRepository {
  Stream<HomeData> getHomeData();
  
  // Future methods for other CRUD operations
  Future<void> updateHomeData(HomeData data);
  Future<void> deleteHomeData(String id);
  Future<void> createHomeData(HomeData data);
}
