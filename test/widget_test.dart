import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dashmeshro/main.dart';

void main() {
  testWidgets('App should render without crashing', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(prefs: prefs));
    await tester.pumpAndSettle();

    // Verify that the app rendered by checking for a core widget,
    // like MaterialApp or our custom AppNavigationScaffold.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
