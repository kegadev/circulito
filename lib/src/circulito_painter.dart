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
  final SectionValueType sectionValueType;
  final CirculitoBackground? background;
  final CirculitoStrokeCap strokeCap;
  final int selectedIndex;

  CirculitoPainter({
    required this.maxsize,
    required this.sections,
    required this.strokeCap,
    required this.isCentered,
    required this.startPoint,
    required this.direction,
    required this.sectionValueType,
    required this.selectedIndex,
    this.background,
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

    var startAngle = Utils.getStartAngle(startPoint);

    /// Draws a section of the wheel.
    void customDraw(
      double percentage,
      Color color,
      int index, [
      Color? hoverColor,
      bool isBackground = false,
    ]) {
      var sweepAngle = 2 * pi * percentage;
      if (direction == CirculitoDirection.counterClockwise) {
        sweepAngle = -sweepAngle;
      }
      var customStrokeWidth = strokeWidth;

      if (index == selectedIndex || (isBackground && selectedIndex == index)) {
        // Stroke transformation on Hover
        final multiplier = isBackground
            ? background!.hoverStrokeMultiplier
            : sections[index].hoverStrokeMultiplier;
        customStrokeWidth = strokeWidth * multiplier;

        // Color transformation on Hover
        if (hoverColor != null) color = hoverColor;
      }

      final sectionPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = customStrokeWidth
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
    if (background != null) {
      customDraw(1, background!.color, -2, background!.hoverColor, true);
    }

    // Sections.
    var valueTotal = Utils.getSectionsTotalValue(sections, sectionValueType);

    for (int i = 0; i < sections.length; i++) {
      double percentage = sectionValueType == SectionValueType.amount
          ? sections[i].value / valueTotal
          : sections[i].value;

      customDraw(percentage, sections[i].color, i, sections[i].hoverColor);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
