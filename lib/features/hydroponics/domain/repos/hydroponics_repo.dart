// lib/features/hydroponics/domain/repos/hydroponics_repo.dart
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';

abstract class HydroponicsRepo {
  Stream<HydroponicsEntity> fetchHydroponicsData();
  Future<void> updatePump(bool isOn);
}