
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';

class HydroponicsModel extends HydroponicsEntity {
  HydroponicsModel({
    required super.humidity,
    required super.temperature,
    required super.phLevel,
    required super.waterLevel,
    required super.pumpStatus,
  });

  factory HydroponicsModel.fromJson(Map<String, dynamic> json) {
    return HydroponicsModel(
      humidity: (json['humidity'] ?? 0).toDouble(),
      temperature: (json['temperature'] ?? 0).toDouble(),
      phLevel: (json['ph_level'] ?? 0).toDouble(),
      waterLevel: (json['water_level_percent'] ?? 0).toDouble(),
      pumpStatus: json['pump_status'] ?? false,
    );
  }
}
