// lib/features/hydroponics/domain/repos/hydroponics_repo.dart
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';

abstract class HydroponicsRepo {
  // Changed to return a Stream for real-time updates
  Stream<HydroponicsEntity> fetchHydroponicsData();
  Future<void> updatePump(bool isOn);
}