import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:happyfarm/core/services/notification_service.dart';
import 'package:happyfarm/features/settings/presentation/manager/settings_cubit.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/entites/warehouse_barn_entite.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/repos/warehouse_barn_repo.dart';

part 'warehouse_state.dart';

class WarehouseBarnCubit extends Cubit<WarehouseBarnState> {
  final WarehouseBarnRepo repo;
  final BuildContext context;
  StreamSubscription<WarehouseBarnEntity>? _subscription;

  bool _lastWarehouseFlame = false;
  bool _lastWarehouseMotion = false;
  bool _lastBarnFlame = false;

  WarehouseBarnCubit(this.repo, this.context) : super(WarehouseBarnInitial()) {
    _subscribeToStream();
  }

  void _subscribeToStream() {
    _subscription = repo.watchWarehouseBarnData().listen(
      (data) {
        _handleNotifications(data);
        emit(WarehouseBarnLoaded(data));
      },
      onError: (e) => emit(WarehouseBarnError(e.toString())),
    );
  }

  void _handleNotifications(WarehouseBarnEntity data) {
    final settings = context.read<SettingsCubit>().state;

    if (!settings.notifications) return;

    final warehouse = data.warehouse;
    final barn = data.barn;

    if (warehouse.flameDetected && !_lastWarehouseFlame) {
      _lastWarehouseFlame = true;
      NotificationService.showLocalNotification(
        id: 100,
        title: '🔥 Warehouse Flame Detected',
        body: 'Please check the warehouse immediately.',
      );
    } else if (!warehouse.flameDetected) {
      _lastWarehouseFlame = false;
    }

    if (warehouse.motionDetected && !_lastWarehouseMotion) {
      _lastWarehouseMotion = true;
      NotificationService.showLocalNotification(
        id: 101,
        title: '👀 Motion in Warehouse',
        body: 'Motion detected in the warehouse zone.',
      );
    } else if (!warehouse.motionDetected) {
      _lastWarehouseMotion = false;
    }

    if (barn.flameDetected && !_lastBarnFlame) {
      _lastBarnFlame = true;
      NotificationService.showLocalNotification(
        id: 102,
        title: '🔥 Barn Flame Detected',
        body: 'Please check the barn zone immediately.',
      );
    } else if (!barn.flameDetected) {
      _lastBarnFlame = false;
    }
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
