import 'dart:math';

import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';
import 'package:circulito/src/utils/utils.dart';

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
  List<Animation<double>>? sectionValues;

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
    this.sectionValues,
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
      CirculitoDecoration decoration,
      int index, [
      bool isBackground = false,
    ]) {
      var sweepAngle = 2 * pi * percentage;
      if (direction == CirculitoDirection.counterClockwise) {
        sweepAngle = -sweepAngle;
      }
      var customStrokeWidth = strokeWidth;
      var baseColor = decoration.color;
      var baseGradient = decoration.gradient;

      if (index == selectedIndex || (isBackground && selectedIndex == index)) {
        // Stroke transformation on Hover.
        final multiplier = isBackground
            ? background!.hoverStrokeMultiplier
            : sections[index].hoverStrokeMultiplier;
        customStrokeWidth = strokeWidth * multiplier;

        // Color transformation on Hover.
        decoration.type == DecorationType.color
            ? baseColor = decoration.hoverColor ?? baseColor
            : baseGradient = decoration.hoverGradient ?? baseGradient;
      }

      final rect = Rect.fromCircle(center: centerOffset, radius: radius);
      final sectionPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = customStrokeWidth
        ..strokeCap = flutterStrokeCap;

      // Asign decoration.
      decoration.type == DecorationType.color
          ? sectionPaint.color = baseColor!
          : sectionPaint.shader = baseGradient!.createShader(rect);

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        sectionPaint,
      );

      // Prevent moving startAngle.
      if (isBackground) return;

      // Set new starting angle for next iteration.
      startAngle += sweepAngle;
    }

    // Background.
    if (background != null) customDraw(1, background!.decoration, -2, true);

    // Sections.
    var valueTotal = Utils.getSectionsTotalValue(sections, sectionValueType);

    // If there are not sectionValues then it is not animated.
    List sectionsToUse = sectionValues ?? sections;

    for (int i = 0; i < sections.length; i++) {
      double percentage = sectionValueType == SectionValueType.amount
          ? sectionsToUse[i].value / valueTotal
          : sectionsToUse[i].value;

      // Draw the section.
      customDraw(percentage, sections[i].decoration, i);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
