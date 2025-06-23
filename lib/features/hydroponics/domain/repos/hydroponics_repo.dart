// lib/features/hydroponics/domain/repos/hydroponics_repo.dart
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';

abstract class HydroponicsRepo {
  Future<HydroponicsEntity> fetchHydroponicsData();
  Future<void> updatePump(bool isOn);
  // If you were to add real historical data fetching, its signature would go here, e.g.:
  // Future<List<Map<String, dynamic>>> fetchHistoricalTdsData({int limit = 3});
}
