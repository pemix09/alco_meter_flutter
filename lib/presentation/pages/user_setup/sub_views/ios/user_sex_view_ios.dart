import 'package:alco_meter_flutter/app/states/user_setup/user_setup_bloc.dart';
import 'package:alco_meter_flutter/app/states/user_setup/user_setup_event.dart';
import 'package:alco_meter_flutter/data/enums/sex.dart';
import 'package:alco_meter_flutter/presentation/components/texts/header_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

var services = GetIt.instance;

class UserSexViewIos extends HookWidget {
  static const routeName = 'sex';

  late final UserSetupBloc bloc;

  UserSexViewIos() {
    bloc = services<UserSetupBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final useSex = useState<String>(Sex.male.name);

    return Column(
      children: [
        HeaderText(useSex.value.toString()),
        CupertinoSegmentedControl<Sex>(
          onValueChanged: (sex) {
            useSex.value = sex.name;
            bloc.add(SexEnteredEvent(userSex: sex));
          },
          children: const <Sex, Widget>{
            Sex.male: Icon(
              Icons.male,
              size: 100,
              color: Colors.black,
            ),
            Sex.female: Icon(
              Icons.female,
              size: 100,
              color: Colors.black,
            )
          },
        ),
      ],
    );
  }
}
