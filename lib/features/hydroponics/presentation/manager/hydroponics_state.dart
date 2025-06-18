part of 'hydroponics_cubit.dart';

abstract class HydroponicsState {}

class HydroponicsInitial extends HydroponicsState {}

class HydroponicsLoaded extends HydroponicsState {
  final HydroponicsEntity data;
  HydroponicsLoaded(this.data);
}

class HydroponicsError extends HydroponicsState {
  final String message;
  HydroponicsError(this.message);
}
