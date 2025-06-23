// lib/features/hydroponics/domain/entites/hydroponics_entity.dart
import 'package:equatable/equatable.dart'; // Import Equatable for better equality checks

class HydroponicsEntity extends Equatable {
  final double humidity;
  final double temperature;
  final double phLevel;
  final double waterLevel;
  final bool pumpStatus;
  final double tds;

  const HydroponicsEntity({
    required this.humidity,
    required this.temperature,
    required this.phLevel,
    required this.waterLevel,
    required this.pumpStatus,
    required this.tds,
  });

  @override
  List<Object> get props => [humidity, temperature, phLevel, waterLevel, pumpStatus, tds];
}