import 'package:alco_meter_flutter/presentation/pages/drink_list/drink_list_page.dart';
import 'package:alco_meter_flutter/presentation/pages/user_setup/views/weight_view.dart';
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
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/${DrinkListPage.routeName}',
        builder: (context, state) => const DrinkListPage(),
      ),
    ],
  );
}
