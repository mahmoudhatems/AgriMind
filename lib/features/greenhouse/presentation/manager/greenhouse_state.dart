
part of 'greenhouse_cubit.dart';

abstract class GreenhouseState extends Equatable { 
  const GreenhouseState(); 

  @override
  List<Object> get props => []; 
}

class GreenhouseInitial extends GreenhouseState {}

class GreenhouseLoading extends GreenhouseState {} 

class GreenhouseLoaded extends GreenhouseState {
  final GreenhouseEntity data;
  const GreenhouseLoaded(this.data); 

  @override
  List<Object> get props => [data]; 
}

class GreenhouseError extends GreenhouseState {
  final String message;
  const GreenhouseError(this.message); 

  @override
  List<Object> get props => [message]; 
}
