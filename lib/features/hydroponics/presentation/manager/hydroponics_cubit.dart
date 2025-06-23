// lib/features/hydroponics/presentation/manager/hydroponics_cubit.dart
import 'dart:async'; // Import for StreamSubscription
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';
import 'package:fl_chart/fl_chart.dart'; // Import FlSpot for chart data

part 'hydroponics_state.dart';

class HydroponicsCubit extends Cubit<HydroponicsState> {
  final HydroponicsRepo hydroponicsRepo;
  List<FlSpot> _tdsHistoryCache = []; // Cache historical TDS data for the chart
  StreamSubscription? _hydroponicsSubscription; // Stream subscription for real-time updates

  HydroponicsCubit(this.hydroponicsRepo) : super(HydroponicsInitial());

  /// Subscribes to the real-time hydroponics data stream.
  /// Updates the state and manages historical TDS data for the chart.
  void fetchHydroData() {
    // Cancel existing subscription to avoid multiple listeners
    _hydroponicsSubscription?.cancel();

    // Emit loading state if not already loading
    if (state is! HydroponicsLoading) {
      emit(HydroponicsLoading());
    }

    _hydroponicsSubscription = hydroponicsRepo.fetchHydroponicsData().listen(
      (data) {
        // Update historical TDS data with the new reading
        List<FlSpot> currentTdsHistory = List.from(_tdsHistoryCache);

        // Remove the oldest point if history grows too long (e.g., keep last 3 points)
        // Adjust this number (e.g., 5, 10) based on how much history you want to display.
        const int maxHistoryPoints = 3;
        if (currentTdsHistory.length >= maxHistoryPoints) {
          currentTdsHistory.removeAt(0);
        }

        // The x-coordinate is simply the new sequential index for the chart.
        final double newX = currentTdsHistory.isEmpty ? 0 : currentTdsHistory.last.x + 1;
        currentTdsHistory.add(FlSpot(newX, data.tds));

        // Re-index x values to be 0, 1, 2... for the chart's display logic
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
        // Handle stream completion if needed (e.g., Firebase connection closed)
        print("Hydroponics data stream is done.");
      },
    );
  }

  /// Updates the pump status in Firebase and then triggers a data fetch
  /// to ensure UI reflects the actual state after the update.
  void togglePump(bool isOn) async {
    try {

      await hydroponicsRepo.updatePump(isOn);

    } catch (e) {
      emit(HydroponicsError(e.toString()));
    }
  }

  /// Override the close method to cancel the stream subscription.
  /// This is crucial for resource management and preventing memory leaks.
  @override
  Future<void> close() {
    _hydroponicsSubscription?.cancel();
    return super.close();
  }
}