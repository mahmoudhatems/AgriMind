// lib/features/hydroponics/data/repos/hydroponics_repo_impl.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/hydroponics/data/models/hydroponics_model.dart'; // Corrected import to hydroponics_model
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';

class HydroponicsRepoImpl implements HydroponicsRepo {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref("hydroponics");

  
  @override
  Stream<HydroponicsEntity> fetchHydroponicsData() {

    return _ref.onValue.map((event) {
      if (event.snapshot.exists) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        return HydroponicsModel.fromJson(data);
      } else {
      
        throw Exception("No hydroponics data found or data structure invalid");
      }
    });
  }

  @override
  Future<void> updatePump(bool isOn) async {
    await _ref.update({'pump_status': isOn});
  }
}