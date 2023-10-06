import 'package:example/examples/examples.dart';
import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyApp widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that first example is shown.
    expect(find.byType(Genders), findsOneWidget);
  });
}
