import 'package:alco_meter_flutter/app/presentation/pages/user_setup/views/sex_view.dart';
import 'package:alco_meter_flutter/app/presentation/pages/user_setup/views/weight_view.dart';
import 'package:alco_meter_flutter/app/presentation/pages/user_setup/views/welcome_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRoute createUserSetupSubRoute(
    GlobalKey<NavigatorState> parentNavigatorKey) {

  return GoRoute(
    path: '/user_setup',
    parentNavigatorKey: parentNavigatorKey,
    builder: (context, state) => const WelcomeView(),
    routes: <RouteBase>[
      GoRoute(
        path: WeightView.routeName,
        builder: (context, state) => WeightView(),
      ),
      GoRoute(
        path: SexView.routeName,
        builder: (context, state) => SexView(),
      ),
    ],
  );
}
