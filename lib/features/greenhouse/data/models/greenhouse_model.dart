import '../../domain/entites/greenhouse_entity.dart';

class GreenhouseModel extends GreenhouseEntity {
  GreenhouseModel({
    required super.fanStatus,
    required super.pumpStatus,
    required super.lightStatus,
    required super.temperature,
    required super.humidity,
    required super.gasLevel,
    required super.soilMoisture,
  });

  factory GreenhouseModel.fromJson(Map<String, dynamic> json) {
    return GreenhouseModel(
      fanStatus: json['fan_status'] ?? false,
      pumpStatus: json['pump_status'] ?? false,
      lightStatus: (json['light_level'] ?? 0) > 0,
      temperature: (json['temperature'] ?? 0).toDouble(),
      humidity: (json['humidity'] ?? 0).toDouble(),
      gasLevel: (json['gas_level'] ?? 0).toDouble(),
      soilMoisture: (json['soil_moisture'] ?? 0).toDouble(),
    );
  }
}
