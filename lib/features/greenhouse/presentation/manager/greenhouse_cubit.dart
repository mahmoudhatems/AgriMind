import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

part 'greenhouse_state.dart';

class GreenhouseCubit extends Cubit<GreenhouseState> {
  GreenhouseCubit() : super(GreenhouseInitial());

  final _database = FirebaseDatabase.instance.ref('greenhouse');

  void fetchGreenhouseData() {
    _database.once().then((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        emit(GreenhouseLoaded(Map<String, dynamic>.from(data as Map)));
      } else {
        emit(GreenhouseError("No data found."));
      }
    }).catchError((e) {
      emit(GreenhouseError(e.toString()));
    });
  }

  void toggleFan(bool isOn) {
    _database.update({'fan_status': isOn});
  }

  void togglePump(bool isOn) {
    _database.update({'pump_status': isOn});
  }

  void toggleLight(bool isOn) {
    _database.update({'light_level': isOn ? 1 : 0});
  }
}
