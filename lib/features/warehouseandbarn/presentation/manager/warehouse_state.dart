part of 'warehouse_cubit.dart';

abstract class WarehouseBarnState {}

class WarehouseBarnInitial extends WarehouseBarnState {}

class WarehouseBarnLoaded extends WarehouseBarnState {
  final WarehouseBarnEntity data;
  WarehouseBarnLoaded(this.data);
}

class WarehouseBarnError extends WarehouseBarnState {
  final String message;
  WarehouseBarnError(this.message);
}
