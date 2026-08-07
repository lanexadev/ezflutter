import 'package:flutter_test/flutter_test.dart';
import 'package:start_dart_app/app/app.dart';

void main() {
  testWidgets('shows the home state', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.text('Home ready'), findsOneWidget);
  });
}
