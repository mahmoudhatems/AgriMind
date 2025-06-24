// lib/features/greenhouse/data/repos/greenhouse_repo_impl.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/greenhouse/data/models/greenhouse_model.dart';
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';
import 'package:happyfarm/features/greenhouse/domain/repos/greenhouse_repo.dart';

class GreenhouseRepoImpl implements GreenhouseRepo {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref("greenhouse");


  @override
  Stream<GreenhouseEntity> fetchGreenhouseData() {
    return _ref.onValue.map((event) {
      if (event.snapshot.exists) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        return GreenhouseModel.fromJson(data);
      } else {
       
        throw Exception("No greenhouse data found or data structure invalid");
      }
    });
  }

  @override
  Future<void> updateFan(bool isOn) async {
    await _ref.update({'fan_status': isOn});
  }

  @override
  Future<void> updatePump(bool isOn) async {
    await _ref.update({'pump_status': isOn});
  }
}
