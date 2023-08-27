import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:circulito/circulito.dart';

void main() {
  testWidgets('MyApp widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the title text is displayed in the app bar
    expect(find.text('Circulito basic example'), findsOneWidget);

    // Verify that the Circulito widget is displayed
    expect(find.byType(Circulito), findsOneWidget);

    // You can add more assertions as needed to test the behavior of your app
  });
}
