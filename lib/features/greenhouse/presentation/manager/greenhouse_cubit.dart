import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';
import 'package:happyfarm/features/greenhouse/domain/repos/greenhouse_repo.dart'; 

part 'greenhouse_state.dart';

class GreenhouseCubit extends Cubit<GreenhouseState> {
  final GreenhouseRepo greenhouseRepo;
  StreamSubscription? _greenhouseSubscription; 

  GreenhouseCubit(this.greenhouseRepo) : super(GreenhouseInitial());

  void fetchGreenhouseData() {
    _greenhouseSubscription?.cancel();

    
    if (state is! GreenhouseLoading) {
      emit(GreenhouseLoading());
    }

    _greenhouseSubscription = greenhouseRepo.fetchGreenhouseData().listen(
      (data) {
        
        emit(GreenhouseLoaded(data));
      },
      onError: (error) {
        
        emit(GreenhouseError(error.toString()));
      },
      onDone: () {
        
        print("Greenhouse data stream is done.");
      },
    );
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
