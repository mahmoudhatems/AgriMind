import 'dart:async';
import 'package:flutter/material.dart'; // لازم ده عشان تستخدم BuildContext
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:happyfarm/core/services/notification_service.dart';
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';
import 'package:happyfarm/features/settings/presentation/manager/settings_cubit.dart';

part 'hydroponics_state.dart';

class HydroponicsCubit extends Cubit<HydroponicsState> {
  final HydroponicsRepo hydroponicsRepo;
  List<FlSpot> _tdsHistoryCache = [];
  StreamSubscription? _hydroponicsSubscription;

  HydroponicsCubit(this.hydroponicsRepo) : super(HydroponicsInitial());

  /// fetches and listens to realtime data
  void fetchHydroData(BuildContext context) {
    _hydroponicsSubscription?.cancel();
    emit(HydroponicsLoading());

    _hydroponicsSubscription = hydroponicsRepo.fetchHydroponicsData().listen(
      (data) {
        _handleNotifications(data, context);

        List<FlSpot> currentTdsHistory = List.from(_tdsHistoryCache);
        const int maxHistoryPoints = 3;

        if (currentTdsHistory.length >= maxHistoryPoints) {
          currentTdsHistory.removeAt(0);
        }

        final double newX = currentTdsHistory.isEmpty ? 0 : currentTdsHistory.last.x + 1;
        currentTdsHistory.add(FlSpot(newX, data.tds));

        final List<FlSpot> chartReadyHistory = currentTdsHistory.asMap().entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.y);
        }).toList();

        _tdsHistoryCache = chartReadyHistory;

        emit(HydroponicsLoaded(data: data, historicalTds: _tdsHistoryCache));
      },
      onError: (error) {
        emit(HydroponicsError(error.toString()));
      },
      onDone: () {
        print("Hydroponics data stream is done.");
      },
    );
  }

  /// Sends notifications based on critical values
  void _handleNotifications(HydroponicsEntity data, BuildContext context) {
    final notiEnabled = context.read<SettingsCubit>().state.notifications;
    if (!notiEnabled) return;

    if (data.tds > 1200) {
      NotificationService.showLocalNotification(
        id: 41,
        title: "⚠️ High TDS Level",
        body: "TDS level exceeded 1200 ppm! Check nutrients.",
      );
    }

    if (data.waterLevel < 25) {
      NotificationService.showLocalNotification(
        id: 42,
        title: "🚨 Water Level Low",
        body: "Water level is below 25%. Refill immediately.",
      );
    }
  }

  /// Toggles the pump manually
  void togglePump(bool isOn) async {
    try {
      await hydroponicsRepo.updatePump(isOn);
    } catch (e) {
      emit(HydroponicsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _hydroponicsSubscription?.cancel();
    return super.close();
  }
}
