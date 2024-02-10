import 'package:alco_meter_flutter/app/states/user_setup/user_setup_bloc.dart';
import 'package:alco_meter_flutter/app/states/user_setup/user_setup_state.dart';
import 'package:alco_meter_flutter/presentation/components/buttons/shaky_nav_button.dart';
import 'package:alco_meter_flutter/presentation/components/texts/big_header_text.dart';
import 'package:alco_meter_flutter/presentation/pages/drink_list/views/drink_list_page.dart';
import 'package:alco_meter_flutter/presentation/pages/user_setup/sub_views/ios/user_sex_view_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:logger/logger.dart';
import 'package:styled_widget/styled_widget.dart';
import 'dart:io' show Platform;

var services = GetIt.instance;

class SexView extends HookWidget {
  static const routeName = 'sexView';
  static const headerText = 'Enter your sex';
  final MaterialColor backgroundColor = Colors.cyan;
  late final GoRouter router;
  late final UserSetupBloc bloc;
  late final Logger logger;

  SexView({super.key}) {
    router = services.get<GoRouter>();
    bloc = services.get<UserSetupBloc>();
    logger = services.get<Logger>();
  }

  @override
  Widget build(BuildContext context) {
    final blocBuilder = useBlocBuilder(bloc);

    return Platform.isIOS || Platform.isMacOS
        ? buildAppleView(false)
        : throw UnimplementedError();
  }

  Widget buildAppleView(bool nextButtonDisabled) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const BigHeaderText(headerText),
          UserSexViewIos(),
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
    try {
      router.push(
        '/${DrinkListPage.routeName}',
        extra: bloc.state.userConfig.toJson(),
      );
    } catch (e) {
      logger.e('Failed to navigate to drink list page, error: $e');
    }
  }
}
