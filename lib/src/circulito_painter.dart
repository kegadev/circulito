import 'dart:math';

import 'package:flutter/material.dart';

import '../circulito.dart';

class CirculitoPainter extends CustomPainter {
  final List<CirculitoSection> sections;

  CirculitoPainter({required this.sections});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    double startAngle = -pi / 2;

    for (var section in sections) {
      final sweepAngle = 2 * pi * section.percentage;
      final paint = Paint()
        ..color = section.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
