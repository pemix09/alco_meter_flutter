import 'package:alco_meter_flutter/app/domain/states/initial_page/initial_bloc.dart';
import 'package:alco_meter_flutter/app/domain/states/initial_page/initial_event.dart';
import 'package:alco_meter_flutter/app/domain/states/initial_page/initial_state.dart';
import 'package:alco_meter_flutter/app/presentation/pages/drink_list/views/drink_list_page.dart';
import 'package:alco_meter_flutter/app/presentation/pages/user_setup/views/weight_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

class InitialPage extends HookWidget {
  final bool isDataLoaded = false;
  late final InitialBloc bloc;
  late final GoRouter router;

  InitialPage() {
    final services = GetIt.instance;
    bloc = services.get<InitialBloc>();
    router = services.get<GoRouter>();

    bloc.add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    useBlocListener<InitialBloc, InitialState>(
      bloc,
      (cubit, value, context) {
        if (bloc.state is SetupCompletedState) {
          router.go('/${DrinkListPage.routeName}');
        } else if (bloc.state is SetupNeededState) {
          router.go('/user_setup/${WeightView.routeName}');
        }
      },
      listenWhen: (state) =>
          state is SetupCompletedState || state is SetupNeededState,
    );
    return Scaffold(
      body: initialPageLoadingWidget(),
    );
  }

  Widget initialPageLoadingWidget() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.deepPurpleAccent],
        ),
      ),
      child:
          const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'AlcoMeter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        CircularProgressIndicator(),
      ]),
    );
  }

  Widget navigatingToNextPageWidget() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.deepPurpleAccent],
        ),
      ),
      child:
          const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'All done!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(Icons.done, color: Colors.white, size: 50),
      ]),
    );
  }

  Widget errorWidget() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.deepPurpleAccent],
        ),
      ),
      child:
          const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Something went wrong!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(Icons.error, color: Colors.white, size: 50),
      ]),
    );
  }
}
