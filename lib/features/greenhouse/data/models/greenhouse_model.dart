
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';

class GreenhouseModel extends GreenhouseEntity {
  GreenhouseModel.fromJson(Map<String, dynamic> json)
      : super(
          fanStatus: json['fan_status'] ?? false,
          pumpStatus: json['pump_status'] ?? false,
          temperature: (json['temperature'] ?? 0).toDouble(),
          humidity: (json['humidity'] ?? 0).toDouble(),
          gasLevel: (json['gas_level'] ?? 0).toDouble(),
          soilMoisture: (json['soil_moisture'] ?? 0).toDouble(),
          lightLevel: (json['light_level'] ?? 0).toDouble(), // ✅ أصبح رقم من 0 لـ 100
        );
}
