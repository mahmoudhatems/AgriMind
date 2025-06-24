import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happyfarm/core/services/notification_service.dart';
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';
import 'package:happyfarm/features/greenhouse/domain/repos/greenhouse_repo.dart';
import 'package:happyfarm/features/settings/presentation/manager/settings_cubit.dart';

part 'greenhouse_state.dart';

class GreenhouseCubit extends Cubit<GreenhouseState> {
  final GreenhouseRepo greenhouseRepo;
  StreamSubscription? _greenhouseSubscription;

  BuildContext? _context;
  bool _alertedTemp = false;
  bool _alertedHumidity = false;

  GreenhouseCubit(this.greenhouseRepo) : super(GreenhouseInitial());

  void fetchGreenhouseData([BuildContext? ctx]) {
    _context = ctx;
    _greenhouseSubscription?.cancel();

    if (state is! GreenhouseLoading) {
      emit(GreenhouseLoading());
    }

    _greenhouseSubscription = greenhouseRepo.fetchGreenhouseData().listen(
      (data) {
        _handleNotifications(data);
        emit(GreenhouseLoaded(data));
      },
      onError: (error) {
        emit(GreenhouseError(error.toString()));
      },
    );
  }

  void _handleNotifications(GreenhouseEntity data) {
    if (_context == null) return;
    final notiEnabled = _context!.read<SettingsCubit>().state.notifications;
    if (!notiEnabled) return;

    if (data.temperature > 35 && !_alertedTemp) {
      _alertedTemp = true;
      NotificationService.showLocalNotification(
        id: 30,
        title: "🌡️ High Temperature!",
        body: "Greenhouse temperature is too high: ${data.temperature}°C",
      );
    } else if (data.temperature <= 35) {
      _alertedTemp = false;
    }

    if (data.humidity > 80 && !_alertedHumidity) {
      _alertedHumidity = true;
      NotificationService.showLocalNotification(
        id: 31,
        title: "💧 High Humidity!",
        body: "Greenhouse humidity is high: ${data.humidity}%",
      );
    } else if (data.humidity <= 80) {
      _alertedHumidity = false;
    }
  }

  void toggleFan(bool isOn) async {
    try {
      await greenhouseRepo.updateFan(isOn);
    } catch (e) {
      emit(GreenhouseError(e.toString()));
    }
  }

  void togglePump(bool isOn) async {
    try {
      await greenhouseRepo.updatePump(isOn);
    } catch (e) {
      emit(GreenhouseError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _greenhouseSubscription?.cancel();
    return super.close();
  }
}
