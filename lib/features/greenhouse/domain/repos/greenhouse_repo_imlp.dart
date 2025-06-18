import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/greenhouse/data/models/greenhouse_model.dart';
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';
import 'package:happyfarm/features/greenhouse/domain/repos/greenhouse_repo.dart';

class GreenhouseRepoImpl implements GreenhouseRepo {
  final _ref = FirebaseDatabase.instance.ref("greenhouse");

  @override
  Future<GreenhouseEntity> fetchGreenhouseData() async {
    final snapshot = await _ref.get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return GreenhouseModel.fromJson(data);
    } else {
      throw Exception("No data found");
    }
  }

  @override
  Future<void> updateFan(bool isOn) async {
    await _ref.update({'fan_status': isOn});
  }

  @override
  Future<void> updatePump(bool isOn) async {
    await _ref.update({'pump_status': isOn});
  }

  @override
  Future<void> updateLight(bool isOn) async {
    await _ref.update({'light_level': isOn ? 1 : 0});
  }
}
