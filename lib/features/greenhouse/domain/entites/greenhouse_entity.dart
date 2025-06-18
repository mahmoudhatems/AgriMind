class GreenhouseEntity {
  final bool fanStatus;
  final bool pumpStatus;
  final bool lightStatus;
  final double temperature;
  final double humidity;
  final double gasLevel;
  final double soilMoisture;

  GreenhouseEntity({
    required this.fanStatus,
    required this.pumpStatus,
    required this.lightStatus,
    required this.temperature,
    required this.humidity,
    required this.gasLevel,
    required this.soilMoisture,
  });

  GreenhouseEntity copyWith({
    bool? fanStatus,
    bool? pumpStatus,
    bool? lightStatus,
    double? temperature,
    double? humidity,
    double? gasLevel,
    double? soilMoisture,
  }) {
    return GreenhouseEntity(
      fanStatus: fanStatus ?? this.fanStatus,
      pumpStatus: pumpStatus ?? this.pumpStatus,
      lightStatus: lightStatus ?? this.lightStatus,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      gasLevel: gasLevel ?? this.gasLevel,
      soilMoisture: soilMoisture ?? this.soilMoisture,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GreenhouseEntity &&
          runtimeType == other.runtimeType &&
          fanStatus == other.fanStatus &&
          pumpStatus == other.pumpStatus &&
          lightStatus == other.lightStatus &&
          temperature == other.temperature &&
          humidity == other.humidity &&
          gasLevel == other.gasLevel &&
          soilMoisture == other.soilMoisture;

  @override
  int get hashCode =>
      fanStatus.hashCode ^
      pumpStatus.hashCode ^
      lightStatus.hashCode ^
      temperature.hashCode ^
      humidity.hashCode ^
      gasLevel.hashCode ^
      soilMoisture.hashCode;
}
