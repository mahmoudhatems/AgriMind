
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';

abstract class HydroponicsRepo {
  Future<HydroponicsEntity> fetchHydroponicsData();
  Future<void> updatePump(bool isOn);
}
