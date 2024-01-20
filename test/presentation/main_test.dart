import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alco_meter_flutter/main.dart';

void main() {
  testWidgets('Main file should build material app', (WidgetTester tester) async {
    var title = 'AlcoMeterTest';
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(title: title));

    var materialAppWidget = find.byType(MaterialApp);

    expect(materialAppWidget, findsOneWidget);
  });
}
