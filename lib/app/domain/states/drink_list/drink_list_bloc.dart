import 'dart:async';

import 'package:alco_meter_flutter/app/domain/services/alco_calc.dart';
import 'package:alco_meter_flutter/app/domain/services/camera_service.dart';
import 'package:alco_meter_flutter/app/domain/services/drink_service.dart';
import 'package:alco_meter_flutter/app/domain/services/user_service.dart';
import 'package:alco_meter_flutter/app/domain/states/drink_list/drink_list_event.dart';
import 'package:alco_meter_flutter/app/domain/states/drink_list/drink_list_state.dart';
import 'package:alco_meter_flutter/app/data/models/drink.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class DrinkListBloc extends Bloc<DrinkListEvent, DrinkListState> {
  late final DrinkService drinkService;
  late final Logger logger;
  late final CameraService cameraService;
  late final AlcoholCalculator alcoCalc;
  late final UserService userService;
  final _promilesController = StreamController<double>.broadcast();

  DrinkListBloc() : super(DrinkListInitialState()) {
    final services = GetIt.instance;

    drinkService = services.get<DrinkService>();
    logger = services.get<Logger>();
    cameraService = services.get<CameraService>();
    alcoCalc = services.get<AlcoholCalculator>();
    userService = services.get<UserService>();

    on<RefreshDrinksListEvent>(
        ((event, emit) async => handleRefreshDrinksEvent(event, emit)));
    on<DeleteDrinkEvent>(
        ((event, emit) async => handleDeleteDrinkEvent(event.drink, emit)));

    Timer.periodic(const Duration(seconds: 1), (timer) {
      logger.d('Calculating promiles');

      if (state.drinksCount > 0) {
        var promiles = alcoCalc.calculateAlcoholLevel(
          state.drinks,
          state.user,
        );
        logger.d('promiles: $promiles');
        _promilesController.sink.add(promiles);
      } else {
        logger.d('no alcohol in blood');
        _promilesController.sink.add(0);
      }
    });
  }

  Future<void> handleRefreshDrinksEvent(
      RefreshDrinksListEvent event, Emitter<DrinkListState> emit) async {
    var promiles = alcoCalc.calculateAlcoholLevel(
      state.drinks,
      state.user ?? await userService.readSetupFromStorage(),
    );
    _promilesController.sink.add(promiles);
    emit(state.copyWith(
        drinks: await drinkService.getDrinks(),
        user: event.user ?? state.user));
  }

  void handleDeleteDrinkEvent(Drink drink, Emitter<DrinkListState> emit) async {
    logger.d('Deleting drink: $drink');
    drinkService.deleteDrink(drink);
    var promiles = alcoCalc.calculateAlcoholLevel(
      state.drinks,
      state.user ?? await userService.readSetupFromStorage(),
    );
    logger.d('promiles: $promiles');
    _promilesController.sink.add(promiles);
    emit(state.copyWith(drinks: await drinkService.getDrinks()));
  }

  Stream<double> get promilesStream => _promilesController.stream;
}
