// lib/features/hydroponics/presentation/manager/hydroponics_state.dart
part of 'hydroponics_cubit.dart';


abstract class HydroponicsState extends Equatable {
  const HydroponicsState(); // Added const constructor for Equatable

  @override
  List<Object> get props => []; // Default empty props for base class
}

class HydroponicsInitial extends HydroponicsState {}

class HydroponicsLoading extends HydroponicsState {} 

class HydroponicsLoaded extends HydroponicsState {
  final HydroponicsEntity data;
  final List<FlSpot> historicalTds; 

  const HydroponicsLoaded({required this.data, this.historicalTds = const []}); 

  @override
  List<Object> get props => [data, historicalTds]; 

}

class HydroponicsError extends HydroponicsState {
  final String message;
  const HydroponicsError(this.message); 

  @override
  List<Object> get props => [message]; 
}
