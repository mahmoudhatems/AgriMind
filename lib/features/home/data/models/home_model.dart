// lib/features/home/data/models/home_model.dart

import 'package:happyfarm/features/home/domain/entites/home_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    required super.flameDetected,
    required super.gasLevel,
    required super.humidity,
    required super.temperature,
    required super.motionDetected,
    required super.windowOpen,
    required super.parkingAvailable,
    required super.parkingOccupied,
    required super.gateOpen,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      flameDetected: json['flame_detected'] ?? false,
      gasLevel: (json['gas_level'] ?? 0).toDouble(),
      humidity: (json['humidity'] ?? 0).toDouble(),
      temperature: (json['temperature'] ?? 0).toDouble(),
      motionDetected: json['motion_detected'] ?? false,
      windowOpen: json['window_open'] ?? false,
      parkingAvailable: json['parking_available'] ?? 0,
      parkingOccupied: json['parking_occupied'] ?? 0,
      gateOpen: json['gate_status'] ?? false,
    );
  }
}
