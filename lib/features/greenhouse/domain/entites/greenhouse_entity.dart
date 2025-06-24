import 'package:equatable/equatable.dart'; 

class GreenhouseEntity extends Equatable { 
  final bool fanStatus;
  final bool pumpStatus;
  final double temperature;
  final double humidity;
  final double gasLevel;
  final double soilMoisture;
  final double lightLevel;

  const GreenhouseEntity({ 
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
  List<Object> get props => [ 
        fanStatus,
        pumpStatus,
        temperature,
        humidity,
        gasLevel,
        soilMoisture,
        lightLevel,
      ];
}
