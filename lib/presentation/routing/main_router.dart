import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:alco_meter_flutter/presentation/pages/user_config/user_config_page.dart';

GoRouter createMainRouter() {
    final _rootNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/${UserConfigPage.routeName}',
      routes: [
        GoRoute(parentNavigatorKey: _rootNavigatorKey,
        path: '/${UserConfigPage.routeName}',
        builder: (context, state) => UserConfigPage(),)
      ]
    ); 
}