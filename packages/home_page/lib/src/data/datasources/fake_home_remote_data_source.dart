import 'dart:async';
import '../../domain/entities/home_data.dart';
import 'home_remote_data_source.dart';

class FakeHomeRemoteDataSource implements IHomeRemoteDataSource {
  @override
  Stream<HomeData> getHomeData() async* {
    yield const HomeData(
      newSells: 5,
      activeRentals: 20,
      activeAmcs: 15,
      totalServices: 40,
      totalCollectedThisMonth: 12500.0,
      amcServices: 10,
      newRoServices: 5,
      repairServices: 25,
      resolutionRatePercent: 95,
      pendingComplaintsCount: 2,
    );
  }

  @override
  Future<void> createHomeData(HomeData data) async {}

  @override
  Future<void> updateHomeData(HomeData data) async {}

  @override
  Future<void> deleteHomeData(String id) async {}
}
