import 'package:alco_meter_flutter/app/services/alco_calc.dart';
import 'package:alco_meter_flutter/app/services/camera_service.dart';
import 'package:alco_meter_flutter/app/services/drink_service.dart';
import 'package:alco_meter_flutter/app/services/user_service.dart';
import 'package:alco_meter_flutter/app/states/add_drink/add_drink_bloc.dart';
import 'package:alco_meter_flutter/app/states/drink_list/drink_list_bloc.dart';
import 'package:alco_meter_flutter/app/states/user_setup/user_setup_bloc.dart';
import 'package:alco_meter_flutter/presentation/routing/main_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:logger/logger.dart';

var services = GetIt.instance;
void main() {
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

  runApp(
    HookedBlocConfigProvider(
      injector: () => services.get,
      builderCondition: (state) => state != null,
      listenerCondition: (state) => state != null,
      child: MyApp(
        title: title,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  late final String title;
  late final GoRouter router;

  MyApp({super.key, required this.title}) {
    router = services<GoRouter>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
