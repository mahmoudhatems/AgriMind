// lib/features/hydroponics/data/models/hydroponics_model.dart
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';

class HydroponicsModel extends HydroponicsEntity {
  const HydroponicsModel({ // Added const constructor
    required super.humidity,
    required super.temperature,
    required super.phLevel,
    required super.waterLevel,
    required super.pumpStatus,
    required super.tds,
  });

  factory HydroponicsModel.fromJson(Map<String, dynamic> json) {
    return HydroponicsModel(
      humidity: (json['humidity'] ?? 0).toDouble(),
      temperature: (json['temperature'] ?? 0).toDouble(),
      phLevel: (json['ph_level'] ?? 0).toDouble(),
      waterLevel: (json['water_level_percent'] ?? 0).toDouble(),
      pumpStatus: json['pump_status'] ?? false,
      tds: (json['tds'] ?? 0).toDouble(), // Parsed tds from JSON
    );
  }
}