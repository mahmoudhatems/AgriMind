import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:happyfarm/core/services/firebase_auth_service.dart';
import 'package:happyfarm/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:happyfarm/features/auth/domain/repos/auth_repo.dart';
import 'package:happyfarm/features/greenhouse/domain/repos/greenhouse_repo.dart';
import 'package:happyfarm/features/greenhouse/domain/repos/greenhouse_repo_imlp.dart';
import 'package:happyfarm/features/home/domain/repos/home_repo.dart';
import 'package:happyfarm/features/home/domain/repos/home_repo_empl.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo.dart';
import 'package:happyfarm/features/hydroponics/domain/repos/hydroponics_repo_impl.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/repos/warehouse_barn_repo.dart';
import 'package:happyfarm/features/warehouseandbarn/domain/repos/wearehouse_barn_repo_impl.dart';
import 'package:happyfarm/features/warehouseandbarn/presentation/manager/warehouse_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {

  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<AuthRepo>(
      AuthRepoImplementation(getIt<FirebaseAuthService>()));

getIt.registerSingleton<GreenhouseRepo>(GreenhouseRepoImpl());


getIt.registerSingleton<HomeRepo>(HomeRepoImpl());
  getIt.registerSingleton<HydroponicsRepo>(HydroponicsRepoImpl());
  getIt.registerLazySingleton<WarehouseBarnRepo>(() => WarehouseBarnRepoImpl());
  getIt.registerFactoryParam<WarehouseBarnCubit, BuildContext, void>(
  (context, _) => WarehouseBarnCubit(getIt(), context),
);


}
