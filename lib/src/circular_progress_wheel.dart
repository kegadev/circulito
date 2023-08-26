import 'package:flutter/material.dart';

import '../circulito.dart';

class CircularProgressWheel extends StatelessWidget {
  final List<CirculitoSection> sections;

  const CircularProgressWheel({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: CustomPaint(
          painter: CirculitoPainter(sections: sections),
        ),
      ),
    );
  }
}
