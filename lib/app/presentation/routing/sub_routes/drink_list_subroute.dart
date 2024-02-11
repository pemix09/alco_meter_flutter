import 'package:alco_meter_flutter/app/data/models/user.dart';
import 'package:alco_meter_flutter/app/presentation/pages/add_drink/views/add_drink_page.dart';
import 'package:alco_meter_flutter/app/presentation/pages/drink_list/views/drink_list_page.dart';
import 'package:alco_meter_flutter/app/presentation/pages/make_photo.dart/views/make_photo_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRoute createDrinkListSubRoute(GlobalKey<NavigatorState> parentNavigatorKey) {
  return GoRoute(
    path: '/${DrinkListPage.routeName}',
    parentNavigatorKey: parentNavigatorKey,
    builder: (context, state) => DrinkListPage(extra: state.extra),
    routes: [
      GoRoute(
        path: AddDrinkPage.routeName,
        builder: (context, state) => AddDrinkPage(),
      ),
      GoRoute(
        path: MakePhotoView.routeName,
        builder: (context, state) => const MakePhotoView(),
      ),
    ],
  );
}
