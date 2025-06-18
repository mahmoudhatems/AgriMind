import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/features/home/domain/entites/home_entity.dart';
import 'package:happyfarm/features/home/domain/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;
  HomeEntity? _cached;

  HomeCubit(this.repo) : super(HomeInitial());

  void fetchHomeData() async {
    try {
      final data = await repo.fetchHomeData();
      if (_cached == null || data != _cached) {
        _cached = data;
        emit(HomeLoaded(data));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void toggleGate(bool isOpen) async {
    await repo.toggleGate(isOpen);
    _cached = _cached?.copyWith(gateOpen: isOpen);
    if (_cached != null) emit(HomeLoaded(_cached!));
  }
}
