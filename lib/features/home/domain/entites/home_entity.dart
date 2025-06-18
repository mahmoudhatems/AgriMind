// lib/features/home/domain/entities/home_entity.dart
class HomeEntity {
  final bool flameDetected;
  final double gasLevel;
  final double humidity;
  final double temperature;
  final bool motionDetected;
  final bool windowOpen;

  final int parkingAvailable;
  final int parkingOccupied;
  final bool gateOpen;

  HomeEntity({
    required this.flameDetected,
    required this.gasLevel,
    required this.humidity,
    required this.temperature,
    required this.motionDetected,
    required this.windowOpen,
    required this.parkingAvailable,
    required this.parkingOccupied,
    required this.gateOpen,
  });

  HomeEntity copyWith({
    bool? flameDetected,
    double? gasLevel,
    double? humidity,
    double? temperature,
    bool? motionDetected,
    bool? windowOpen,
    int? parkingAvailable,
    int? parkingOccupied,
    bool? gateOpen,
  }) {
    return HomeEntity(
      flameDetected: flameDetected ?? this.flameDetected,
      gasLevel: gasLevel ?? this.gasLevel,
      humidity: humidity ?? this.humidity,
      temperature: temperature ?? this.temperature,
      motionDetected: motionDetected ?? this.motionDetected,
      windowOpen: windowOpen ?? this.windowOpen,
      parkingAvailable: parkingAvailable ?? this.parkingAvailable,
      parkingOccupied: parkingOccupied ?? this.parkingOccupied,
      gateOpen: gateOpen ?? this.gateOpen,
    );
  }
}
