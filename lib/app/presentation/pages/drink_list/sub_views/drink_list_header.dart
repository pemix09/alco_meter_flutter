import 'package:alco_meter_flutter/app/domain/states/drink_list/drink_list_bloc.dart';
import 'package:alco_meter_flutter/app/domain/states/drink_list/drink_list_event.dart';
import 'package:alco_meter_flutter/app/presentation/components/texts/header_text.dart';
import 'package:alco_meter_flutter/app/presentation/pages/add_drink/views/add_drink_page.dart';
import 'package:alco_meter_flutter/app/presentation/pages/drink_list/views/drink_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

var services = GetIt.instance;

class DrinkListHeader extends HookWidget {
  late final DrinkListBloc bloc;
  late final GoRouter router;

  DrinkListHeader({super.key}) {
    bloc = services.get<DrinkListBloc>();
    router = services.get<GoRouter>();
  }

  @override
  Widget build(BuildContext context) {
    final blocBuilder = useBlocBuilder(bloc);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Badge(
          label: Text(bloc.state.drinksCount.toString()),
          child: const Icon(
            Icons.local_drink,
            color: Colors.white,
            size: 40,
          ),
        ),
        Text(
          'drinks: ${bloc.state.drinksCount}',
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
        IconButton(
          onPressed: () => navigateToUserSetup(),
          icon: const Icon(
            Icons.settings_accessibility,
            size: 40,
          ),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () => navigateToAddDrinkPage(),
          icon: const Icon(
            Icons.add,
            size: 40,
          ),
          color: Colors.white,
        ),
      ],
    )
        .padding(
          left: 30,
          right: 30,
          top: 20,
          bottom: 20,
        )
        .backgroundColor(Colors.deepPurple);
  }

  void navigateToAddDrinkPage() {
    router.push('/${DrinkListPage.routeName}/${AddDrinkPage.routeName}');
  }

  void navigateToUserSetup() {
    router.push('/user_setup/weight');
  }

  void refreshDrinkList() {
    bloc.add(RefreshDrinksListEvent());
  }
}
