import 'package:happyfarm/features/warehouseandbarn/domain/entites/warehouse_barn_entite.dart';

class WarehouseBarnModel extends WarehouseBarnEntity {
  WarehouseBarnModel.fromJson({
    required Map<String, dynamic> warehouse,
    required Map<String, dynamic> barn,
  }) : super(
          warehouse: WarehouseEntity(
            temperature: (warehouse['temperature'] ?? 0).toDouble(),
            humidity: (warehouse['humidity'] ?? 0).toDouble(),
            gasLevel: (warehouse['gas_level'] ?? 0).toDouble(),
            flameDetected: warehouse['flame_detected'] ?? false,
            motionDetected: warehouse['motion_detected'] ?? false,
            alarmActive: warehouse['alarm_active'] ?? false,
            doorStatus: warehouse['door_status'] ?? false,
          ),
          barn: BarnEntity(
            temperature: (barn['temperature'] ?? 0).toDouble(),
            humidity: (barn['humidity'] ?? 0).toDouble(),
            soundLevel: (barn['sound_level'] ?? 0).toDouble(),
            flameDetected: barn['flame_detected'] ?? false,
            doorStatus: barn['door_status'] ?? false,
            fanStatus: barn['fan_status'] ?? false,
          ),
        );
}
