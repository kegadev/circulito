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
              // Custom animation.
              animation: CirculitoAnimation(
                duration: 600,
                curve: Curves.easeInOut,
              ),
              maxSize: 480,
              strokeWidth: 80,
              background: CirculitoBackground(),
              strokeCap: CirculitoStrokeCap.round,
              direction: CirculitoDirection.clockwise,
              sectionValueType: SectionValueType.percentage,
              sections: [
                // Male percentage.
                CirculitoSection(
                  value: .35,
                  decoration: const CirculitoDecoration.fromColor(
                    Colors.blue,
                    hoverColor: Colors.blueAccent,
                  ),
                  onHover: () {
                    // Do something when mouse over this section.
                  },
                  onTap: () {
                    // Do something when mouse tapped this section.
                  },
                ),

                // Female percentage.
                CirculitoSection(
                  value: .40,
                  decoration: const CirculitoDecoration.fromGradient(
                    LinearGradient(colors: [Colors.pink, Colors.red]),
                    hoverGradient: LinearGradient(colors: [
                      Colors.pinkAccent,
                      Colors.redAccent,
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
