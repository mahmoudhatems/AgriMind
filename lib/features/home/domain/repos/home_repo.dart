// lib/features/home/domain/repos/home_repo.dart

import 'package:happyfarm/features/home/domain/entites/home_entity.dart';

abstract class HomeRepo {
  Future<HomeEntity> fetchHomeData();
  Future<void> toggleGate(bool isOpen);
}
