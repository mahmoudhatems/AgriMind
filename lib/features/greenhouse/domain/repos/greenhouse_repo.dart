import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';

abstract class GreenhouseRepo {
  // Change to return a Stream for real-time updates
  Stream<GreenhouseEntity> fetchGreenhouseData();
  Future<void> updateFan(bool isOn);
  Future<void> updatePump(bool isOn);
}
