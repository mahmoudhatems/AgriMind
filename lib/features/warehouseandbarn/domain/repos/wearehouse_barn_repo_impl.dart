import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/warehouseandbarn/data/models/warehouse_barn_model.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/entites/warehouse_barn_entite.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/repos/warehouse_barn_repo.dart';

class WarehouseBarnRepoImpl extends WarehouseBarnRepo {
  final _db = FirebaseDatabase.instance;

  @override
  Stream<WarehouseBarnEntity> watchWarehouseBarnData() {
    return _db.ref().onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      final warehouseData = Map<String, dynamic>.from(data['warehouse'] ?? {});
      final barnData = Map<String, dynamic>.from(data['barn'] ?? {});

      return WarehouseBarnModel.fromJson(
        warehouse: warehouseData,
        barn: barnData,
      );
    });
  }

  @override
  Future<void> updateDevice(String zone, String key, bool value) async {
    await _db.ref(zone).update({key: value});
  }
}
