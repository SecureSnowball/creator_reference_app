import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:test_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Test Login', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Finds the login button and taps it.
      final Finder loginButton = find.byKey(const ValueKey('loginButton'));
      await tester.tap(loginButton);
      await tester.pump(const Duration(milliseconds: 1000));

      // Finds the email field and types email.
      final Finder emailField = find.byKey(const ValueKey('emailInput'));
      await tester.enterText(emailField, 'john@example.com');
      await tester.pump(const Duration(milliseconds: 1000));

      // Finds the password field and types password.
      final Finder passwordField = find.byKey(const ValueKey('passwordInput'));
      await tester.enterText(passwordField, 'password');
      await tester.pump(const Duration(milliseconds: 1000));

      // Finds the login button and taps it.
      final Finder loginButton2 = find.byKey(const ValueKey('loginButton'));
      await tester.tap(loginButton2);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      // expect(find('login'), findsOneWidget);
    });
  });
}