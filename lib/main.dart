import 'package:alco_meter_flutter/app/services/user_service.dart';
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

  services.registerLazySingleton<Logger>(() => Logger());
  services.registerLazySingleton<UserSetupBloc>(() => UserSetupBloc());
  services.registerLazySingleton<GoRouter>(() => createMainRouter());
  services.registerLazySingleton<UserService>(() => UserService());

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
