import 'package:alco_meter_flutter/app/states/drink_list/drink_list_bloc.dart';
import 'package:alco_meter_flutter/app/states/drink_list/drink_list_event.dart';
import 'package:alco_meter_flutter/data/models/drink.dart';
import 'package:alco_meter_flutter/presentation/pages/drink_list/views/drink_list_page.dart';
import 'package:alco_meter_flutter/presentation/pages/make_photo.dart/views/make_photo_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class DrinkListElement extends StatelessWidget {
  late final DrinkListBloc bloc;
  final Drink drink;
  late final GoRouter router;

  DrinkListElement({super.key, required this.drink}) {
    final services = GetIt.instance;
    bloc = services.get<DrinkListBloc>();
    router = services.get<GoRouter>();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(drink.id.toString()),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => deleteDrinkActionTapped(),
        ),
        children: [
          SlidableAction(
            onPressed: (context) => deleteDrinkActionTapped(),
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: CupertinoListTile(
        title: Text(
          '${drink.type.name}, ${drink.percentage}%, ${drink.amount}ml',
          style: const TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
            fontSize: 25,
          ),
        ),
        subtitle: Text('${drink.timeAdded}'),
      ),
    );
  }

  void deleteDrinkActionTapped() {
    bloc.add(DeleteDrinkEvent(drink: drink));
  }
}
