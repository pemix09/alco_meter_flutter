import 'package:alco_meter_flutter/app/domain/states/user_setup/user_setup_bloc.dart';
import 'package:alco_meter_flutter/app/presentation/components/buttons/shaky_nav_button.dart';
import 'package:alco_meter_flutter/app/presentation/components/texts/big_header_text.dart';
import 'package:alco_meter_flutter/app/presentation/pages/user_setup/sub_views/ios/user_weight_view_ios.dart';
import 'package:alco_meter_flutter/app/presentation/pages/user_setup/views/sex_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

var services = GetIt.instance;

class WeightView extends HookWidget {
  static const routeName = 'weight';
  static const headerText = 'Enter your weight';
  final MaterialColor backgroundColor = Colors.deepPurple;
  late final GoRouter router;
  late final UserSetupBloc bloc;

  WeightView({super.key}) {
    router = services.get<GoRouter>();
    bloc = services.get<UserSetupBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final blocBuilder = useBlocBuilder(bloc);
    
    return buildAppleView(false);
  }

  Widget buildAppleView(bool nextButtonDisabled) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const BigHeaderText(headerText),
          UserWeightViewIos(),
          ShakyNavButton(
            disabled: nextButtonDisabled,
            onPressed: () => handleNavButtonPress(),
            text: 'next',
          ).padding(all: 10)
        ],
      ).center(),
    );
  }

  void handleNavButtonPress() {
    router.push('/user_setup/${SexView.routeName}');
  }
}
