import 'package:alco_meter_flutter/app/alco_meter.dart';
import 'package:alco_meter_flutter/app/domain/repositories/drink_repo.dart';
import 'package:alco_meter_flutter/app/domain/repositories/user_repo.dart';
import 'package:alco_meter_flutter/app/domain/services/alco_calc.dart';
import 'package:alco_meter_flutter/app/domain/services/camera_service.dart';
import 'package:alco_meter_flutter/app/domain/services/drink_service.dart';
import 'package:alco_meter_flutter/app/domain/services/user_service.dart';
import 'package:alco_meter_flutter/app/domain/states/add_drink/add_drink_bloc.dart';
import 'package:alco_meter_flutter/app/domain/states/drink_list/drink_list_bloc.dart';
import 'package:alco_meter_flutter/app/domain/states/initial_page/initial_bloc.dart';
import 'package:alco_meter_flutter/app/domain/states/user_setup/user_setup_bloc.dart';
import 'package:alco_meter_flutter/app/data/enums/drink_type.dart';
import 'package:alco_meter_flutter/app/data/enums/sex.dart';
import 'package:alco_meter_flutter/app/data/models/drink.dart';
import 'package:alco_meter_flutter/app/data/models/user.dart';
import 'package:alco_meter_flutter/app/presentation/routing/main_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:logger/logger.dart';

var services = GetIt.instance;
void main() async {
  var title = 'AlcoMeter';

  services.registerFactory<Logger>(() => Logger());
  services.registerLazySingleton<UserSetupBloc>(() => UserSetupBloc());
  services.registerLazySingleton<GoRouter>(() => createMainRouter());
  services.registerLazySingleton<UserService>(() => UserService());
  services.registerLazySingleton<DrinkListBloc>(() => DrinkListBloc());
  services.registerLazySingleton<AddDrinkBloc>(() => AddDrinkBloc());
  services.registerLazySingleton<DrinkService>(() => DrinkService());
  services.registerLazySingleton<CameraService>(() => CameraService());
  services.registerFactory<AlcoholCalculator>(() => AlcoholCalculator());
  services.registerLazySingleton<DrinkRepository>(() => DrinkRepository());
  services.registerFactory<UserRepository>(() => UserRepository());
  services.registerLazySingleton<InitialBloc>(() => InitialBloc());

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter()); 
  Hive.registerAdapter(DrinkAdapter());
  Hive.registerAdapter(SexAdapter());
  Hive.registerAdapter(DrinkTypeAdapter());

  runApp(
    HookedBlocConfigProvider(
      injector: () => services.get,
      builderCondition: (state) => state != null,
      listenerCondition: (state) => state != null,
      child: AlcoMeter(
        title: title,
      ),
    ),
  );
}