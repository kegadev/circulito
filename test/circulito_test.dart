import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:circulito/circulito.dart';

void main() {
  testWidgets('Circulito widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      Circulito(
        sections: [
          CirculitoSection(color: Colors.red, value: 0.4),
          CirculitoSection(color: Colors.blue, value: 0.6),
        ],
        maxSize: 150,
      ),
    );

    expect(find.byType(Circulito), findsOneWidget);
    // Perform your testing/assertions here
  });
}
