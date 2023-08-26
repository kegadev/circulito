import 'package:flutter/material.dart';

import '../circulito.dart';

class CircularProgressWheel extends StatelessWidget {
  final List<CirculitoSection> sections;

  const CircularProgressWheel({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirculitoPainter(sections: sections),
      child: Container(),
    );
  }
}
