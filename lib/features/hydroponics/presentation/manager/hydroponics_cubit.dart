// lib/features/hydroponics/presentation/manager/hydroponics_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';
import 'package:fl_chart/fl_chart.dart'; 

part 'hydroponics_state.dart';

class HydroponicsCubit extends Cubit<HydroponicsState> {
  final HydroponicsRepo hydroponicsRepo;
  HydroponicsEntity? _cache; // Cache current data
  List<FlSpot> _tdsHistoryCache = []; // Cache historical TDS data

  HydroponicsCubit(this.hydroponicsRepo) : super(HydroponicsInitial());

  void fetchHydroData() async {
    try {
      if (state is! HydroponicsLoading) { // Prevent multiple loading states
        emit(HydroponicsLoading());
      }

      final data = await hydroponicsRepo.fetchHydroponicsData();

      // --- Simulate fetching historical TDS data ---
      // In a real app, you would fetch this from your Firebase DB
      // (e.g., a specific collection/node for historical readings with timestamps).
      // For demonstration, we'll build a small history:
      // We will keep the last few (e.g., 2) historical points + the current one.
      List<FlSpot> currentTdsHistory = List.from(_tdsHistoryCache);

      // Remove the oldest point if history grows too long (e.g., keep last 3 points)
      if (currentTdsHistory.length >= 3) {
        currentTdsHistory.removeAt(0); // Keep only the last 2 and add current
      }

      // Adjust x-coordinates to be relative time (0, 1, 2 for last 3 points)
      // and add the new current TDS value.
      final double newX = currentTdsHistory.isEmpty ? 0 : currentTdsHistory.last.x + 1;
      currentTdsHistory.add(FlSpot(newX, data.tds));

      // Re-index x values to be 0, 1, 2 for the chart's display logic
      final List<FlSpot> chartReadyHistory = currentTdsHistory.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value.y);
      }).toList();

      _tdsHistoryCache = chartReadyHistory; // Update cache


      // Only emit if data or historical data has changed
      // This is a basic check; for complex objects, you might need deep equality.
      // Equatable on HydroponicsEntity and FlSpot helps here.
      if (data != _cache || !_areFlSpotListsEqual(_tdsHistoryCache, (state is HydroponicsLoaded ? (state as HydroponicsLoaded).historicalTds : []))) {
        _cache = data;
        emit(HydroponicsLoaded(data: data, historicalTds: _tdsHistoryCache));
      } else {
        // If data hasn't changed, and we're already in a loaded state, do nothing
        // Or re-emit the same state to trigger rebuild if needed for other reasons
        // (e.g., refresh indicator completion).
        // For simplicity, we just don't re-emit if nothing visually changes.
      }

    } catch (e) {
      emit(HydroponicsError(e.toString()));
    }
  }

  void togglePump(bool isOn) async {
    try {
      // Optimistically update UI if desired, then fetch actual data
      if (state is HydroponicsLoaded) {
        final currentData = (state as HydroponicsLoaded).data;
        emit(HydroponicsLoaded(
          data: HydroponicsEntity(
            humidity: currentData.humidity,
            temperature: currentData.temperature,
            phLevel: currentData.phLevel,
            waterLevel: currentData.waterLevel,
            pumpStatus: isOn, // Optimistic update
            tds: currentData.tds,
          ),
          historicalTds: (state as HydroponicsLoaded).historicalTds,
        ));
      }
      await hydroponicsRepo.updatePump(isOn);
      fetchHydroData(); // Fetch real data to confirm
    } catch (e) {
      emit(HydroponicsError(e.toString()));
      // Revert optimistic update if there was an error
      fetchHydroData();
    }
  }

  // Helper to compare FlSpot lists for changes
  bool _areFlSpotListsEqual(List<FlSpot> list1, List<FlSpot> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].x != list2[i].x || list1[i].y != list2[i].y) {
        return false;
      }
    }
    return true;
  }
}
