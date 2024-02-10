import 'package:alco_meter_flutter/app/services/drink_service.dart';
import 'package:alco_meter_flutter/app/states/add_drink/add_drink_event.dart';
import 'package:alco_meter_flutter/app/states/add_drink/add_drink_state.dart';
import 'package:alco_meter_flutter/data/enums/drink_type.dart';
import 'package:alco_meter_flutter/data/models/drink.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class AddDrinkBloc extends Bloc<DrinkEvent, AddDrinkState> {
  late final DrinkService drinkService;
  late final Logger logger;

  AddDrinkBloc() : super(AddDrinkInitialState()) {
    final services = GetIt.instance;
    logger = services.get<Logger>();
    drinkService = services.get<DrinkService>();
    on<DrinkTypeChangedEvent>((event, emit) async =>
        handleDrinkTypeChangedEvent(event.drinkType, emit));
    on<DrinkVolumeChangedEvent>((event, emit) async =>
        handleDrinkVolumeChangedEvent(event.drinkVolume, emit));
    on<DrinkPercentageChangedEvent>((event, emit) async =>
        handleDrinkPercentageChangedEvent(event.drinkPercentage, emit));
    on<AddDrinkEvent>((event, emit) async => handleAddDrinkEvent(emit));
  }

  handleDrinkTypeChangedEvent(
      DrinkType drinkType, Emitter<AddDrinkState> emit) {
    logger.d('Drink type changed: $drinkType');
    emit(state.copyWith(drinkType: drinkType));
  }

  handleDrinkVolumeChangedEvent(
      double drinkVolume, Emitter<AddDrinkState> emit) {
    logger.d('Drink volume changed: $drinkVolume');
    emit(state.copyWith(volume: drinkVolume));
  }

  handleDrinkPercentageChangedEvent(
      double drinkPercentage, Emitter<AddDrinkState> emit) {
    logger.d('Drink percentage changed: $drinkPercentage');
    emit(state.copyWith(percentage: drinkPercentage));
  }

  handleAddDrinkEvent(Emitter<AddDrinkState> emit) {
    logger.d(
      'Drink added, type: ${state.drinkType}, volume: ${state.volume}, percentage: ${state.percentage}',
    );
    drinkService.addDrink(
      Drink(
          amount: state.volume,
          type: state.drinkType,
          percentage: state.percentage,
          timeAdded: DateTime.now()
    ));
    
    emit(DrinkAddedState());
  }
}
