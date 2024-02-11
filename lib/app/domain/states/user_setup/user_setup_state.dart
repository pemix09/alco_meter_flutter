import 'package:alco_meter_flutter/app/data/enums/sex.dart';
import 'package:alco_meter_flutter/app/data/models/user.dart';

class UserSetupState {
  late final User userConfig;

  UserSetupState(
      {required double userHeight,
      required double userWeight,
      required Sex userSex,
      required String id}) {
    userConfig = User(
      height: userHeight,
      weight: userWeight,
      sex: userSex,
      id: id,
    );
  }

  UserSetupState copyWith(
      {double? height, double? weight, Sex? sex, String? id}) {
    return UserSetupState(
      userHeight: height ?? userConfig.height,
      userWeight: weight ?? userConfig.weight,
      userSex: sex ?? userConfig.sex,
      id: id ?? userConfig.id,
    );
  }
}

class UserSetupInitialState extends UserSetupState {
  UserSetupInitialState()
      : super(
          userHeight: 0,
          userWeight: 0,
          userSex: Sex.male,
          id: '',
        );
}

class UserSetupDoneState extends UserSetupInitialState {
  UserSetupDoneState() : super();
}
