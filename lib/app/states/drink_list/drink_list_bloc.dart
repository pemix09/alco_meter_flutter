import 'dart:async';

import 'package:alco_meter_flutter/app/services/alco_calc.dart';
import 'package:alco_meter_flutter/app/services/camera_service.dart';
import 'package:alco_meter_flutter/app/services/drink_service.dart';
import 'package:alco_meter_flutter/app/states/drink_list/drink_list_event.dart';
import 'package:alco_meter_flutter/app/states/drink_list/drink_list_state.dart';
import 'package:alco_meter_flutter/data/models/drink.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class DrinkListBloc extends Bloc<DrinkListEvent, DrinkListState> {
  late final DrinkService drinkService;
  late final Logger logger;
  late final CameraService cameraService;
  late final AlcoholCalculator alcoCalc;
  final _promilesController = StreamController<double>.broadcast();

  DrinkListBloc(): super(DrinkListInitialState()) {
    final services = GetIt.instance;
    
    drinkService = services.get<DrinkService>();
    logger = services.get<Logger>();
    cameraService = services.get<CameraService>();
    alcoCalc = services.get<AlcoholCalculator>();

    on<RefreshDrinksListEvent>(((event, emit) async => handleRefreshDrinksEvent(event, emit)));
    on<DeleteDrinkEvent>(((event, emit) async => handleDeleteDrinkEvent(event.drink, emit)));

    Timer.periodic(const Duration(seconds: 5), (timer) { 
      logger.d('Calculating promiles');

      if (state.drinksCount > 0) {
        var promiles = alcoCalc.calculateAlcoholLevel(state.drinks, state.user);
        logger.d('promiles: $promiles');
        _promilesController.sink.add(promiles);
      }
    });
  }

  void handleRefreshDrinksEvent(RefreshDrinksListEvent event, Emitter<DrinkListState> emit) {
    logger.d('Refreshing drinks list');
    emit(state.copyWith(drinks: drinkService.drinks, user: event.user ?? state.user));
  }

  void handleDeleteDrinkEvent(Drink drink, Emitter<DrinkListState> emit) {
    logger.d('Deleting drink: $drink');
    drinkService.deleteDrink(drink);
    emit(state.copyWith(drinks: drinkService.drinks));
  }

  Stream<double> get promilesStream => _promilesController.stream;
}