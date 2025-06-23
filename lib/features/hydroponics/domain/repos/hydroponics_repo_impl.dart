// lib/features/hydroponics/data/repos/hydroponics_repo_impl.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/hydroponics/data/models/hydroponics_model.dart'; // Corrected import to hydroponics_model
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';

class HydroponicsRepoImpl implements HydroponicsRepo {
  // Reference to the main hydroponics data node in Firebase Realtime Database
  final DatabaseReference _ref = FirebaseDatabase.instance.ref("hydroponics");

  /// Fetches hydroponics data in real-time as a stream.
  /// Converts DataSnapshot events into HydroponicsModel objects.
  @override
  Stream<HydroponicsEntity> fetchHydroponicsData() {
    // Listen for changes in the 'hydroponics' node.
    // The .map() operator transforms each DataSnapshot into a HydroponicsModel.
    return _ref.onValue.map((event) {
      if (event.snapshot.exists) {
        // Ensure the snapshot's value is a Map before converting to HydroponicsModel.
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        return HydroponicsModel.fromJson(data);
      } else {
        // If snapshot doesn't exist, you might throw an error or return a default/empty entity.
        // For a stream, this might indicate data was deleted or not yet present.
        // Throwing an error here will cause the stream to close with an error.
        throw Exception("No hydroponics data found or data structure invalid");
      }
    });
  }

  /// Updates the 'pump_status' in the Firebase Realtime Database.
  @override
  Future<void> updatePump(bool isOn) async {
    await _ref.update({'pump_status': isOn});
  }
}