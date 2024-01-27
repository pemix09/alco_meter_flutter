import 'package:alco_meter_flutter/app/services/user_service.dart';
import 'package:alco_meter_flutter/app/states/user_setup/user_setup_event.dart';
import 'package:alco_meter_flutter/app/states/user_setup/user_setup_state.dart';
import 'package:alco_meter_flutter/data/enums/sex.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

var services = GetIt.instance;

class UserSetupBloc extends Bloc<UserSetupEvent, UserSetupState> {
  late final Logger logger;
  late final UserService userService;

  UserSetupBloc(): super(UserSetupState()) {
    logger = services.get<Logger>();
    userService = services.get<UserService>();

    on<SexEnteredEvent>(
        (event, emit) async => handleSexEnteredEvent(event.sex, emit));
    on<WeightEnteredEvent>(
        (event, emit) async => handleWeightEnteredEvent(event.weight, emit));
    on<HeightEnteredEvent>(
        (event, emit) async => handleHeightEnteredEvent(event.height, emit));
  }

  void handleHeightEnteredEvent(double height, Emitter<UserSetupState> emit) {
    logger.d('User height entered: $height cm');
    emit(UserHeightChangedState(userHeight: height));
  }

  void handleWeightEnteredEvent(double weight, Emitter<UserSetupState> emit) {
    logger.d('User weight entered: $weight kg');
    emit(UserWeightChangedState(userWeight: weight));
  }

  void handleSexEnteredEvent(Sex sex, Emitter<UserSetupState> emit) {
    logger.d('User sex entered: $sex');
    emit(UserSexChangedState(userSex: sex));
  }
}
