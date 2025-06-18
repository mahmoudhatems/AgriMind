import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';
import 'package:happyfarm/features/greenhouse/domain/repos/greenhouse_repo.dart';

part 'greenhouse_state.dart';

class GreenhouseCubit extends Cubit<GreenhouseState> {
  final GreenhouseRepo greenhouseRepo;
  GreenhouseEntity? _cachedState;

  GreenhouseCubit(this.greenhouseRepo) : super(GreenhouseInitial());

  void fetchGreenhouseData() async {
    try {
      final data = await greenhouseRepo.fetchGreenhouseData();

      // Avoid emitting if the data hasn't changed
      if (_cachedState == null || data != _cachedState) {
        _cachedState = data;
        emit(GreenhouseLoaded(data));
      }
    } catch (e) {
      emit(GreenhouseError(e.toString()));
    }
  }

  void toggleFan(bool isOn) async {
    await greenhouseRepo.updateFan(isOn);
    _updateLocalState(_cachedState?.copyWith(fanStatus: isOn));
  }

  void togglePump(bool isOn) async {
    await greenhouseRepo.updatePump(isOn);
    _updateLocalState(_cachedState?.copyWith(pumpStatus: isOn));
  }

  void toggleLight(bool isOn) async {
    await greenhouseRepo.updateLight(isOn);
    _updateLocalState(_cachedState?.copyWith(lightStatus: isOn));
  }

  void _updateLocalState(GreenhouseEntity? newState) {
    if (newState != null) {
      _cachedState = newState;
      emit(GreenhouseLoaded(_cachedState!));
    }
  }
}
