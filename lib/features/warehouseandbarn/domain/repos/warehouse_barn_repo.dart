
import 'package:happyfarm/features/warehouseandbarn/domain/entites/warehouse_barn_entite.dart';

abstract class WarehouseBarnRepo {
  Future<WarehouseBarnEntity> fetchWarehouseBarnData();
  Future<void> updateDevice(String zone, String key, bool value);
}
