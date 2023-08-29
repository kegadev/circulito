import 'dart:math';

import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

class CirculitoPainter extends CustomPainter {
  final double strokeWidth;
  final Color? backgroundColor;
  final CirculitoStrokeCap strokeCap;
  final List<CirculitoSection> sections;
  final double maxsize;
  final bool isCentered;

  CirculitoPainter({
    this.backgroundColor,
    this.strokeWidth = 20,
    required this.maxsize,
    required this.sections,
    required this.strokeCap,
    required this.isCentered,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var sizeToDraw = maxsize;
    if (size.width >= 0.0 || size.height >= 0.0) {
      sizeToDraw = min(maxsize, min(size.width, size.height));
    }

    final width = sizeToDraw / 2;
    final height = sizeToDraw / 2;

    final centerOffset = isCentered
        ? Offset(size.width / 2, size.height / 2)
        : Offset(width, height);

    final halfStrokeWidth = strokeWidth / 2;
    final radius = min(width - halfStrokeWidth, height - halfStrokeWidth);

    final flutterStrokeCap = strokeCap == CirculitoStrokeCap.butt //
        ? StrokeCap.butt
        : StrokeCap.round;

    var startAngle = -pi / 2;

    void customDraw(
      double percentage,
      Color color, [
      bool isBackground = false,
    ]) {
      var sweepAngle = 2 * pi * percentage;

      final sectionPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = flutterStrokeCap;

      canvas.drawArc(
        Rect.fromCircle(center: centerOffset, radius: radius),
        startAngle,
        sweepAngle,
        false,
        sectionPaint,
      );

      if (isBackground) return;
      startAngle += sweepAngle;
    }

    // Background.
    if (backgroundColor != null) customDraw(1, backgroundColor!, true);

    // Sections.
    for (int i = 0; i < sections.length; i++) {
      customDraw(sections[i].percentage, sections[i].color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
