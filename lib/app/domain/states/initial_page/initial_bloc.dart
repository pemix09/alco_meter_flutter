import 'package:alco_meter_flutter/app/domain/services/drink_service.dart';
import 'package:alco_meter_flutter/app/domain/services/user_service.dart';
import 'package:alco_meter_flutter/app/domain/states/initial_page/initial_event.dart';
import 'package:alco_meter_flutter/app/domain/states/initial_page/initial_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class InitialBloc extends Bloc<InitEvent, InitialState> {
  late final UserService userService;
  late final DrinkService drinkService;

  InitialBloc() : super(LoadingState()) {
    final services = GetIt.instance;
    userService = services.get<UserService>();
    drinkService = services.get<DrinkService>();

    on<InitEvent>((event, emit) async => handleInitialPageLoadedEvent(emit));
  }

  Future<void> handleInitialPageLoadedEvent(Emitter<InitialState> emit) async {
    emit(LoadingState());

    var setup = await userService.readSetupFromStorage();
    await drinkService.getDrinks();

    if (setup == null || setup.id == null || setup.id == '') {
      emit (SetupNeededState());
    } else {
      emit (SetupCompletedState());
    }
  }
}