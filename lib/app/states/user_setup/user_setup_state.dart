import 'package:alco_meter_flutter/data/enums/sex.dart';
import 'package:alco_meter_flutter/data/models/user_config.dart';

class UserSetupState {
  late final UserSetup userConfig;

  UserSetupState({double? userHeight, double? userWeight, Sex? userSex}) {
    userConfig = UserSetup(
      height: userHeight,
      weight: userWeight,
      sex: userSex,
    );
  }

  UserSetupState copyWith({double? height, double? weight, Sex? sex}) {
    return UserSetupState(
      userHeight: height ?? userConfig.height,
      userWeight: weight ?? userConfig.weight,
      userSex: sex ?? userConfig.sex,
    );
  }
}

class UserSetupInitialState extends UserSetupState {
  UserSetupInitialState() : super();
}

class UserWeightChangedState extends UserSetupState {
  final double userWeight;

  UserWeightChangedState({required this.userWeight});
}

class UserHeightChangedState extends UserSetupState {
  final double userHeight;

  UserHeightChangedState({required this.userHeight});
}

class UserSexChangedState extends UserSetupState {
  final Sex userSex;

  UserSexChangedState({required this.userSex});
}

class UserSetupDoneState extends UserSetupState {
  UserSetupDoneState() : super();
}
