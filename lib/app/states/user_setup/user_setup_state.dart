import 'package:alco_meter_flutter/data/enums/sex.dart';
import 'package:alco_meter_flutter/data/models/user_config.dart';

class UserSetupState {
  late final UserSetup userConfig;

  UserSetupState() {
    userConfig = UserSetup();
  }

  UserSetupState.copyWith({double? height, double? weight, Sex? sex}) {
    userConfig = UserSetup();

    userConfig.userHeight = height ?? userConfig.height;
    userConfig.userWeight = weight ?? userConfig.weight;
    userConfig.userSex = sex ?? userConfig.sex;
  }
}

class UserSetupInitialState extends UserSetupState {
  UserSetupInitialState() : super();
}

class UserWeightChangedState extends UserSetupState {
  final double userWeight;

  UserWeightChangedState({required this.userWeight})
      : super.copyWith(weight: userWeight);
}

class UserHeightChangedState extends UserSetupState {
  final double userHeight;

  UserHeightChangedState({required this.userHeight})
      : super.copyWith(height: userHeight);
}

class UserSexChangedState extends UserSetupState {
  final Sex userSex;

  UserSexChangedState({required this.userSex}) : super.copyWith(sex: userSex);
}

class UserSetupDoneState extends UserSetupState {
  UserSetupDoneState() : super();
}
