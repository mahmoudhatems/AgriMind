import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/entites/warehouse_barn_entite.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/repos/warehouse_barn_repo.dart';

part 'warehouse_state.dart';

class WarehouseBarnCubit extends Cubit<WarehouseBarnState> {
  final WarehouseBarnRepo repo;
  WarehouseBarnEntity? _cache;

  WarehouseBarnCubit(this.repo) : super(WarehouseBarnInitial());

  void fetchData() async {
    try {
      final data = await repo.fetchWarehouseBarnData();
      _cache = data;
      emit(WarehouseBarnLoaded(data));
    } catch (e) {
      emit(WarehouseBarnError(e.toString()));
    }
  }

  void toggleDevice({
    required String zone,
    required String key,
    required bool value,
  }) async {
    try {
      await repo.updateDevice(zone, key, value);

      if (_cache != null) {
        final updated = _updateEntity(_cache!, zone, key, value);
        _cache = updated;
        emit(WarehouseBarnLoaded(updated));
      }
    } catch (e) {
      emit(WarehouseBarnError(e.toString()));
    }
  }

  WarehouseBarnEntity _updateEntity(
      WarehouseBarnEntity entity, String zone, String key, bool value) {
    if (zone == "warehouse") {
      final w = entity.warehouse;
      return WarehouseBarnEntity(
        warehouse: WarehouseEntity(
          temperature: w.temperature,
          humidity: w.humidity,
          gasLevel: w.gasLevel,
          flameDetected: w.flameDetected,
          motionDetected: w.motionDetected,
          alarmActive: key == "alarm_active" ? value : w.alarmActive,
          doorStatus: key == "door_status" ? value : w.doorStatus,
        ),
        barn: entity.barn,
      );
    } else {
      final b = entity.barn;
      return WarehouseBarnEntity(
        warehouse: entity.warehouse,
        barn: BarnEntity(
          temperature: b.temperature,
          humidity: b.humidity,
          soundLevel: b.soundLevel,
          flameDetected: b.flameDetected,
          doorStatus: key == "door_status" ? value : b.doorStatus,
          fanStatus: key == "fan_status" ? value : b.fanStatus,
        ),
      );
    }
  }
}
