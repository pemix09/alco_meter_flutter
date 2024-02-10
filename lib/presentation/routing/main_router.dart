import 'package:alco_meter_flutter/data/models/user_config.dart';
import 'package:alco_meter_flutter/presentation/pages/drink_list/views/drink_list_page.dart';
import 'package:alco_meter_flutter/presentation/pages/user_setup/views/weight_view.dart';
import 'package:alco_meter_flutter/presentation/routing/sub_routes/drink_list_subroute.dart';
import 'package:alco_meter_flutter/presentation/routing/sub_routes/user_setup_subroute.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRouter createMainRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/user_setup/${WeightView.routeName}',
    routes: [
      createUserSetupSubRoute(rootNavigatorKey),
      createDrinkListSubRoute(rootNavigatorKey),
    ],
  );
}
