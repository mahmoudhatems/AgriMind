part of 'greenhouse_cubit.dart';

abstract class GreenhouseState {}

class GreenhouseInitial extends GreenhouseState {}

class GreenhouseLoaded extends GreenhouseState {
  final Map<String, dynamic> data;
  GreenhouseLoaded(this.data);
}

class GreenhouseError extends GreenhouseState {
  final String message;
  GreenhouseError(this.message);
}
