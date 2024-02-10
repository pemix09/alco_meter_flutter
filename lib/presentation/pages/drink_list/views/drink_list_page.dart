import 'dart:convert';

import 'package:alco_meter_flutter/app/states/drink_list/drink_list_bloc.dart';
import 'package:alco_meter_flutter/app/states/drink_list/drink_list_event.dart';
import 'package:alco_meter_flutter/app/states/drink_list/drink_list_state.dart';
import 'package:alco_meter_flutter/data/models/user_config.dart';
import 'package:alco_meter_flutter/presentation/pages/drink_list/sub_views/drink_list_element.dart';
import 'package:alco_meter_flutter/presentation/pages/drink_list/sub_views/drink_list_header.dart';
import 'package:alco_meter_flutter/presentation/pages/drink_list/sub_views/drink_list_summary.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

class DrinkListPage extends HookWidget {
  static const String routeName = 'drinkList';
  static const MaterialColor backgroundColor = Colors.indigo;
  static const String drinkListText = 'Your drinks list';
  late final DrinkListBloc bloc;

  DrinkListPage({super.key, Object? extra, DrinkListBloc? drinkListBloc}) {
    final services = GetIt.instance;
    bloc = drinkListBloc ?? services.get<DrinkListBloc>();

    if (extra != null) {
      bloc.add(
        RefreshDrinksListEvent(
          user: UserSetup.fromJson(extra as String),
        ),
      );
    } else {
      RefreshDrinksListEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final blocBuilder = useBlocBuilder(bloc);
    final drinks = bloc.state.drinks.map((el) {
      return DrinkListElement(drink: el);
    });
    if (Platform.isIOS || Platform.isMacOS) {
      return SafeArea(
        bottom: false,
        child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text(drinkListText),
          ),
          child: CupertinoListSection(
            header: DrinkListHeader(),
            footer: DrinkListSummary(),
            children: drinks.toList(),
          ).center(),
        ),
      );
    } else {
      throw UnimplementedError('Material view not implemented');
    }
  }
}
