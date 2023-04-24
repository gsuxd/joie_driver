import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:joiedriver/components/default_button.dart';
import 'package:joiedriver/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Login Flow", () {
    testWidgets('Login user', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Iniciar Sesión'), findsOneWidget);
      await tester.enterText(
          find.byType(TextFormField).first, "asdasd@asd.com");
      await tester.enterText(find.byType(TextFormField).last, "00000000");
      await tester.sendKeyDownEvent(LogicalKeyboardKey.escape);
      await tester.tap(find.byType(ButtonDef));
      await tester.pump(const Duration(seconds: 2));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Trigger a frame.
      await tester.pumpAndSettle(const Duration(milliseconds: 16),
          EnginePhase.sendSemanticsUpdate, const Duration(seconds: 30));
      expect(find.text("Punto Fijo"), findsOneWidget);
    });
  });
}
