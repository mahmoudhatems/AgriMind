// lib/features/hydroponics/data/repos/hydroponics_repo_impl.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/hydroponics/data/models/hydroponics.dart';
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';


class HydroponicsRepoImpl implements HydroponicsRepo {
  final _ref = FirebaseDatabase.instance.ref("hydroponics");
  // If you had a separate node for history:
  // final _historyRef = FirebaseDatabase.instance.ref("hydroponics_history");


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

  // If you were to implement real historical data fetching from Firebase:
  /*
  @override
  Future<List<Map<String, dynamic>>> fetchHistoricalTdsData({int limit = 3}) async {
    // This assumes a structure like:
    // hydroponics_history:
    //   tds_readings:
    //     <timestamp_key_1>: { "value": X, "timestamp": Y }
    //     <timestamp_key_2>: { "value": Z, "timestamp": A }
    final snapshot = await _historyRef.child('tds_readings')
        .orderByChild('timestamp') // Order by timestamp to get latest
        .limitToLast(limit)        // Limit to desired number of historical points
        .get();

    if (snapshot.exists && snapshot.value is Map) {
      final Map<String, dynamic> rawData = Map<String, dynamic>.from(snapshot.value as Map);
      List<Map<String, dynamic>> historicalData = [];
      rawData.forEach((key, value) {
        historicalData.add(Map<String, dynamic>.from(value));
      });
      // Sort by timestamp to ensure correct order for chart
      historicalData.sort((a, b) => (a['timestamp'] as int).compareTo(b['timestamp'] as int));
      return historicalData;
    }
    return []; // Return empty list if no history
  }
  */
}
