import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/warehouseandbarn/data/models/warehouse_barn_model.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/entites/warehouse_barn_entite.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/repos/warehouse_barn_repo.dart';

class WarehouseBarnRepoImpl extends WarehouseBarnRepo {
  final _db = FirebaseDatabase.instance;

  @override
  Future<WarehouseBarnEntity> fetchWarehouseBarnData() async {
    final warehouseSnap = await _db.ref('warehouse').get();
    final barnSnap = await _db.ref('barn').get();

    if (warehouseSnap.exists && barnSnap.exists) {
      return WarehouseBarnModel.fromJson(
        warehouse: Map<String, dynamic>.from(warehouseSnap.value as Map),
        barn: Map<String, dynamic>.from(barnSnap.value as Map),
      );
    } else {
      throw Exception("Warehouse or Barn data not found.");
    }
  }

  @override
  Future<void> updateDevice(String zone, String key, bool value) async {
    await _db.ref(zone).update({key: value});
  }
}
