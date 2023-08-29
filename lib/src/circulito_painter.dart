import 'dart:math';

import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

/// Paints the Circulito widget in canvas.
///
/// Shouldn't be used directly. Use [Circulito] instead.
class CirculitoPainter extends CustomPainter {
  final double maxsize;
  final List<CirculitoSection> sections;
  final double strokeWidth;
  final bool isCentered;
  final StartPoint startPoint;
  final CirculitoDirection direction;
  final Color? backgroundColor;
  final CirculitoStrokeCap strokeCap;

  CirculitoPainter({
    required this.maxsize,
    required this.sections,
    required this.strokeCap,
    required this.isCentered,
    required this.startPoint,
    required this.direction,
    this.backgroundColor,
    this.strokeWidth = 20,
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

    var startAngle = getStartAngle(startPoint);
    void customDraw(
      double percentage,
      Color color, [
      bool isBackground = false,
    ]) {
      var sweepAngle = 2 * pi * percentage;
      if (direction == CirculitoDirection.counterClockwise) {
        sweepAngle = -sweepAngle;
      }

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
