import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/hydroponics/data/models/hydroponics.dart';
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';


class HydroponicsRepoImpl implements HydroponicsRepo {
  final _ref = FirebaseDatabase.instance.ref("hydroponics");

  @override
  Future<HydroponicsEntity> fetchHydroponicsData() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return HydroponicsModel.fromJson(data);
    } else {
      throw Exception("No hydroponics data found");
    }
  }

  @override
  Future<void> updatePump(bool isOn) async {
    await _ref.update({'pump_status': isOn});
  }
}
