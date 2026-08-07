import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:start_dart_app/main_dev.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('launches the development application', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Home ready'), findsOneWidget);
  });
}
