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

  DrinkListBloc(): super(DrinkListInitialState()) {
    final services = GetIt.instance;
    
    drinkService = services.get<DrinkService>();
    logger = services.get<Logger>();
    cameraService = services.get<CameraService>();

    on<LoadingDrinksListEvent>(((event, emit) async => handleRefreshDrinksEvent(event, emit)));
    on<DeleteDrinkEvent>(((event, emit) async => handleDeleteDrinkEvent(event.drink, emit)));
  }

  void handleRefreshDrinksEvent(LoadingDrinksListEvent event, Emitter<DrinkListState> emit) {
    logger.d('Refreshing drinks list');
    emit(state.copyWith(drinks: drinkService.drinks, user: event.user ?? state.user));
  }

  void handleDeleteDrinkEvent(Drink drink, Emitter<DrinkListState> emit) {
    logger.d('Deleting drink: $drink');
    drinkService.deleteDrink(drink);
    emit(state.copyWith(drinks: drinkService.drinks));
  }
}