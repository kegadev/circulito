library circulito;

export 'src/circulito_section.dart';
export 'src/circulito_painter.dart';
export 'src/circular_progress_wheel.dart';

import 'package:flutter/material.dart';

import 'src/circulito_painter.dart';
import 'src/circulito_section.dart';

class Circulito extends StatelessWidget {
  final List<CirculitoSection> sections;

  Circulito({required this.sections});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirculitoPainter(sections: sections),
    );
  }
}
// export 'src/circulito_animated_progress.dart';

// /// A Calculator.
// class Calculator {
//   /// Returns [value] plus 1.
//   int addOne(int value) => value + 1;
// }
