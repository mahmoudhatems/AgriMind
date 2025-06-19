class GreenhouseEntity {
  final bool fanStatus;
  final bool pumpStatus;
  final double temperature;
  final double humidity;
  final double gasLevel;
  final double soilMoisture;
  final double lightLevel; // ✅ تم التعديل هنا

  GreenhouseEntity({
    required this.fanStatus,
    required this.pumpStatus,
    required this.temperature,
    required this.humidity,
    required this.gasLevel,
    required this.soilMoisture,
    required this.lightLevel,
  });

  GreenhouseEntity copyWith({
    bool? fanStatus,
    bool? pumpStatus,
    double? temperature,
    double? humidity,
    double? gasLevel,
    double? soilMoisture,
    double? lightLevel,
  }) {
    return GreenhouseEntity(
      fanStatus: fanStatus ?? this.fanStatus,
      pumpStatus: pumpStatus ?? this.pumpStatus,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      gasLevel: gasLevel ?? this.gasLevel,
      soilMoisture: soilMoisture ?? this.soilMoisture,
      lightLevel: lightLevel ?? this.lightLevel,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GreenhouseEntity &&
          fanStatus == other.fanStatus &&
          pumpStatus == other.pumpStatus &&
          temperature == other.temperature &&
          humidity == other.humidity &&
          gasLevel == other.gasLevel &&
          soilMoisture == other.soilMoisture &&
          lightLevel == other.lightLevel;

  @override
  int get hashCode =>
      fanStatus.hashCode ^
      pumpStatus.hashCode ^
      temperature.hashCode ^
      humidity.hashCode ^
      gasLevel.hashCode ^
      soilMoisture.hashCode ^
      lightLevel.hashCode;
}
