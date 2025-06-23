// lib/features/hydroponics/domain/entites/hydroponics_entity.dart
class HydroponicsEntity {
  final double humidity;
  final double temperature;
  final double phLevel;
  final double waterLevel;
  final bool pumpStatus;
  final double tds; 

  HydroponicsEntity({
    required this.humidity,
    required this.temperature,
    required this.phLevel,
    required this.waterLevel,
    required this.pumpStatus,
    required this.tds, 
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HydroponicsEntity &&
          runtimeType == other.runtimeType &&
          humidity == other.humidity &&
          temperature == other.temperature &&
          phLevel == other.phLevel &&
          waterLevel == other.waterLevel &&
          pumpStatus == other.pumpStatus &&
          tds == other.tds); 

  @override
  int get hashCode =>
      humidity.hashCode ^
      temperature.hashCode ^
      phLevel.hashCode ^
      waterLevel.hashCode ^
      pumpStatus.hashCode ^
      tds.hashCode; 
}
