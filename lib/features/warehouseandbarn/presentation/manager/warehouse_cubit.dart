import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/entites/warehouse_barn_entite.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/repos/warehouse_barn_repo.dart';

part 'warehouse_state.dart';

class WarehouseBarnCubit extends Cubit<WarehouseBarnState> {
  final WarehouseBarnRepo repo;
  StreamSubscription<WarehouseBarnEntity>? _subscription;

  WarehouseBarnCubit(this.repo) : super(WarehouseBarnInitial()) {
    _subscribeToRealTimeUpdates();
  }

  void _subscribeToRealTimeUpdates() {
    _subscription = repo.watchWarehouseBarnData().listen(
      (data) => emit(WarehouseBarnLoaded(data)),
      onError: (e) => emit(WarehouseBarnError(e.toString())),
    );
  }

  Future<void> toggleDevice({
    required String zone,
    required String key,
    required bool value,
  }) async {
    try {
      await repo.updateDevice(zone, key, value);
    } catch (e) {
      emit(WarehouseBarnError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
