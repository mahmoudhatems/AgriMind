class HydroponicsEntity {
  final double humidity;
  final double temperature;
  final double phLevel;
  final double waterLevel;
  final bool pumpStatus;

  HydroponicsEntity({
    required this.humidity,
    required this.temperature,
    required this.phLevel,
    required this.waterLevel,
    required this.pumpStatus,
  });
}
