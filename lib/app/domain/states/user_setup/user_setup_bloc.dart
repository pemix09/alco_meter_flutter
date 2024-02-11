import 'package:alco_meter_flutter/app/domain/services/user_service.dart';
import 'package:alco_meter_flutter/app/domain/states/user_setup/user_setup_event.dart';
import 'package:alco_meter_flutter/app/domain/states/user_setup/user_setup_state.dart';
import 'package:alco_meter_flutter/app/data/enums/sex.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class UserSetupBloc extends Bloc<UserSetupEvent, UserSetupState> {
  late final Logger logger;
  late final UserService userService;

  UserSetupBloc(): super(UserSetupInitialState()) {
    var services = GetIt.instance;
    logger = services.get<Logger>();
    userService = services.get<UserService>();

    on<SexEnteredEvent>(
        (event, emit) async => handleSexEnteredEvent(event.sex, emit));
    on<WeightEnteredEvent>(
        (event, emit) async => handleWeightEnteredEvent(event.weight, emit));
    on<HeightEnteredEvent>(
        (event, emit) async => handleHeightEnteredEvent(event.height, emit));
    on<UserConfigFinishedEvent>((event, emit) async => handleSaveUserEvent(emit));
  }

  void handleHeightEnteredEvent(double height, Emitter<UserSetupState> emit) {
    logger.d('User height entered: $height cm');
    emit(state.copyWith(height: height));
  }

  void handleWeightEnteredEvent(double weight, Emitter<UserSetupState> emit) {
    logger.d('User weight entered: $weight kg');
    emit(state.copyWith(weight: weight));
  }

  void handleSexEnteredEvent(Sex sex, Emitter<UserSetupState> emit) {
    logger.d('User sex entered: $sex');
    emit(state.copyWith(sex: sex));
  }

  Future<void> handleSaveUserEvent(Emitter<UserSetupState> emit) async {
    logger.d('Saving user setup to storage');
    await userService.saveSetupToStorage(state.userConfig);
    emit(UserSetupDoneState());
  }
}
