import 'package:alco_meter_flutter/app/domain/states/add_drink/add_drink_bloc.dart';
import 'package:alco_meter_flutter/app/domain/states/add_drink/add_drink_event.dart';
import 'package:alco_meter_flutter/app/presentation/pages/add_drink/subviews/amount_select.dart';
import 'package:alco_meter_flutter/app/presentation/pages/add_drink/subviews/drink_select.dart';
import 'package:alco_meter_flutter/app/presentation/pages/add_drink/subviews/percetange_select.dart';
import 'package:alco_meter_flutter/app/presentation/pages/drink_list/views/drink_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

final services = GetIt.instance;

class AddDrinkPage extends StatelessWidget {
  static const routeName = 'add-drink';
  static const text = 'Add drink';
  static const MaterialColor backgroundColor = Colors.indigo;
  late final AddDrinkBloc bloc;
  late final GoRouter router;

  AddDrinkPage({super.key}) {
    bloc = services.get<AddDrinkBloc>();
    router = services.get<GoRouter>();
  }

  @override
  Widget build(BuildContext context) {
    return buildIosView();
  }

  Widget buildIosView() {
    return SafeArea(
      bottom: false,
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => goBackClicked(),
          ),
          middle: const Text(text),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CupertinoFormSection(
              header: const Text('Select drink type'),
              children: [
                const SizedBox(height: 30),
                DrinkSelect().center(),
                const SizedBox(height: 30),
                PercentageSelect(),
                const SizedBox(height: 30),
                AmountSelect(),
                ElevatedButton(
                  onPressed: () => addDrinkClicked(),
                  child: const Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      Text('Add drink'),
                    ],
                  ),
                )
              ],
            ),
          ],
        ).center(),
      ),
    );
  }

  void goBackClicked() {
    router.pop();
  }

  void addDrinkClicked() {
    bloc.add(AddDrinkEvent());
    router.go('/${DrinkListPage.routeName}');
  }
}
