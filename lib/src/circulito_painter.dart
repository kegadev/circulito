import 'dart:math';

import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

class CirculitoPainter extends CustomPainter {
  final List<CirculitoSection> sections;
  final double strokeWidth;
  final CirculitoStrokeCap strokeCap;

  CirculitoPainter(
      {required this.sections,
      this.strokeWidth = 20,
      this.strokeCap = CirculitoStrokeCap.round});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width / 2;
    final height = size.height / 2;

    final center = Offset(width, height);

    final halfStrokeWidth = strokeWidth / 2;
    final radius = min(width - halfStrokeWidth, height - halfStrokeWidth);

    // Calculate total percentage
    double sumSection(sum, section) => sum + section.percentage;
    final totalPercentage = sections.fold(0.0, sumSection);

    var startAngle = -pi / 2;

    final isStrokeCapButt = strokeCap == CirculitoStrokeCap.butt;

    for (int i = 0; i < sections.length; i++) {
      final sectionPercentage = isStrokeCapButt
          ? sections[i].percentage
          : sections[i].percentage / totalPercentage;
      var sweepAngle = 2 * pi * sectionPercentage;

      final sectionPaint = Paint()
        ..color = sections[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = isStrokeCapButt ? StrokeCap.butt : StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        sectionPaint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
