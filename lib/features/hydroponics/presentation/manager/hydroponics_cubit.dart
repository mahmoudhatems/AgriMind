import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/features/hydroponics/domain/entites/hydroponics_entity.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';

part 'hydroponics_state.dart';

class HydroponicsCubit extends Cubit<HydroponicsState> {
  final HydroponicsRepo hydroponicsRepo;
  HydroponicsEntity? _cache;

  HydroponicsCubit(this.hydroponicsRepo) : super(HydroponicsInitial());

  void fetchHydroData() async {
    try {
      final data = await hydroponicsRepo.fetchHydroponicsData();
      if (data != _cache) {
        _cache = data;
        emit(HydroponicsLoaded(data));
      }
    } catch (e) {
      emit(HydroponicsError(e.toString()));
    }
  }
void togglePump(bool isOn) async {
  try {
    await hydroponicsRepo.updatePump(isOn);
    fetchHydroData();
  } catch (e) {
    emit(HydroponicsError(e.toString()));
  }
}
}
