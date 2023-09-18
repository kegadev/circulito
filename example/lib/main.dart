import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Keys to prevent redraws on SetState calls.
  final parentKey = GlobalKey();
  final childKey = GlobalKey();

  var _text = 'Circulito';

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
            child: SingleChildScrollView(
              child: Circulito(
                key: parentKey,
                // Custom animation.
                animation: CirculitoAnimation(
                  duration: 600,
                  curve: Curves.easeInOut,
                ),
                maxSize: 510,
                strokeWidth: 50,
                childStackingOrder: ChildStackingOrder.behindParent,
                background: CirculitoBackground(),
                strokeCap: CirculitoStrokeCap.butt,
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
                      setState(() => _text = 'Blue');
                      // Do something when mouse over this section.
                    },
                    onTap: () {
                      // Do something when mouse tapped this section.
                    },
                  ),

                  // Female percentage.
                  CirculitoSection(
                    value: .45,
                    decoration: const CirculitoDecoration.fromGradient(
                      LinearGradient(colors: [Colors.pink, Colors.red]),
                      hoverGradient: LinearGradient(colors: [
                        Colors.pinkAccent,
                        Colors.redAccent,
                      ]),
                    ),
                  ),
                ],
                // Circulito as a child.
                child: _getChild(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Circulito _getChild() {
    return Circulito(
      key: childKey,
      maxSize: 380,
      strokeWidth: 50,
      strokeCap: CirculitoStrokeCap.butt,
      background: CirculitoBackground(),
      startPoint: StartPoint.bottom,
      animation: CirculitoAnimation(),
      sectionValueType: SectionValueType.percentage,
      sections: [
        CirculitoSection(
          value: .2,
          onHover: () => setState(() => _text = 'Green'),
          onTap: () => {
            // Do something when mouse tapped this section.
          },
          decoration: const CirculitoDecoration.fromColor(Colors.green),
        ),
        CirculitoSection(
          value: .3,
          decoration: const CirculitoDecoration.fromColor(Colors.pink),
        ),
        CirculitoSection(
          value: .2,
          decoration: const CirculitoDecoration.fromColor(Colors.amber),
        ),
      ],

      // Grandchild, to show text changes when sections are hovered.
      child: Text(_text),
    );
  }
}
