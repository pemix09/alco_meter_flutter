import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alco_meter_flutter/main.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../mocks/logger_mock.dart';

void main() {
  setUp(() {
    GetIt.instance.reset();
  });
  testWidgets('Main file should build material app', (WidgetTester tester) async {

    var dependecyContainer = GetIt.instance;
    dependecyContainer.registerLazySingleton<Logger>(() => LoggerMock());
    var title = 'AlcoMeterTest';

    await tester.pumpWidget(MyApp(title: title));

    var materialAppWidget = find.byType(MaterialApp);

    expect(materialAppWidget, findsOneWidget);
  });
}
