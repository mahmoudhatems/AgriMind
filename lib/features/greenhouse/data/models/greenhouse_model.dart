class GreenhouseModel {
  final bool fanStatus;
  final bool pumpStatus;
  final int lightLevel;
  final double temperature;
  final double humidity;
  final double gasLevel;
  final double soilMoisture;

  GreenhouseModel({
    required this.fanStatus,
    required this.pumpStatus,
    required this.lightLevel,
    required this.temperature,
    required this.humidity,
    required this.gasLevel,
    required this.soilMoisture,
  });

  factory GreenhouseModel.fromJson(Map<String, dynamic> json) {
    return GreenhouseModel(
      fanStatus: json['fan_status'] ?? false,
      pumpStatus: json['pump_status'] ?? false,
      lightLevel: json['light_level'] ?? 0,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0,
      humidity: (json['humidity'] as num?)?.toDouble() ?? 0,
      gasLevel: (json['gas_level'] as num?)?.toDouble() ?? 0,
      soilMoisture: (json['soil_moisture'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fan_status': fanStatus,
      'pump_status': pumpStatus,
      'light_level': lightLevel,
      'temperature': temperature,
      'humidity': humidity,
      'gas_level': gasLevel,
      'soil_moisture': soilMoisture,
    };
  }
}
