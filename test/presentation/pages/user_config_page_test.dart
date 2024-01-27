import 'package:alco_meter_flutter/presentation/pages/user_config/user_config_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'dart:io' show Platform;
import 'package:logger/logger.dart';
import '../../mocks/logger_mock.dart';

void main() {
  setUp(() {
    GetIt.instance.reset();
  });

  testWidgets('user config page should show correct type of scaffold',
      (tester) async {
    var getIt = GetIt.instance;
    getIt.registerLazySingleton<Logger>(() => LoggerMock());

    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: UserConfigPage(userConfigContent: Spacer(),),
      ),
    );

    var scaffoldWidget = find.byType(Scaffold);
    var iosScaffoldWidget = find.byType(CupertinoPageScaffold);

    if (Platform.isIOS) {
      expect(scaffoldWidget, findsNothing);
      expect(iosScaffoldWidget, findsOneWidget);
    } else {
      expect(scaffoldWidget, findsOneWidget);
      expect(iosScaffoldWidget, findsNothing);
    }
  });
}
