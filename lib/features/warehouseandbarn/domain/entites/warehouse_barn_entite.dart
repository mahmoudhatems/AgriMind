class WarehouseBarnEntity {
  final WarehouseEntity warehouse;
  final BarnEntity barn;

  WarehouseBarnEntity({
    required this.warehouse,
    required this.barn,
  });
}

class WarehouseEntity {
  final double temperature;
  final double humidity;
  final double gasLevel;
  final bool flameDetected;
  final bool motionDetected;
  final bool alarmActive;
  final bool doorStatus;

  WarehouseEntity({
    required this.temperature,
    required this.humidity,
    required this.gasLevel,
    required this.flameDetected,
    required this.motionDetected,
    required this.alarmActive,
    required this.doorStatus,
  });
}

class BarnEntity {
  final double temperature;
  final double humidity;
  final double soundLevel;
  final bool flameDetected;
  final bool doorStatus;
  final bool fanStatus;

  BarnEntity({
    required this.temperature,
    required this.humidity,
    required this.soundLevel,
    required this.flameDetected,
    required this.doorStatus,
    required this.fanStatus,
  });
}
