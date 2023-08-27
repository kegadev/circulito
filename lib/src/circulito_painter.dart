import 'dart:math';

import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

class CirculitoPainter extends CustomPainter {
  final double strokeWidth;
  final Color? backgroundColor;
  final CirculitoStrokeCap strokeCap;
  final List<CirculitoSection> sections;

  CirculitoPainter({
    this.backgroundColor,
    this.strokeWidth = 20,
    required this.sections,
    required this.strokeCap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width / 2;
    final height = size.height / 2;
    final center = Offset(width, height);

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
        Rect.fromCircle(center: center, radius: radius),
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
