import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Circulito basic example')),
        body: Center(
          child: Container(
            width: 500,
            height: 500,
            color: Colors.grey.shade200,
            child: Circulito(
              maxSize: 480,
              strokeWidth: 80,
              startPoint: StartPoint.left,
              background: CirculitoBackground(),
              strokeCap: CirculitoStrokeCap.round,
              direction: CirculitoDirection.clockwise,
              sectionValueType: SectionValueType.percentage,
              sections: [
                // Male percentage.
                CirculitoSection(
                  value: .35,
                  color: Colors.blue,
                  hoverColor: Colors.blueAccent,
                ),

                // Female percentage.
                CirculitoSection(
                  value: .40,
                  color: Colors.pink,
                  hoverColor: Colors.pinkAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Container(width: 150, height: 50, color: Colors.green),
}
