import 'dart:math';

import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';
import 'package:circulito/src/utils/utils.dart';

/// Paints the Circulito widget in canvas.
///
/// Shouldn't be used directly. Use [Circulito] instead.
class CirculitoPainter extends CustomPainter {
  /// Max size of the Circulito widget.
  final double maxsize;

  /// List of sections to draw.
  final List<CirculitoSection> sections;

  /// Stroke width of the Circulito widget.
  ///
  /// This represent the pixels the stroke will have.
  final double strokeWidth;

  /// If the Circulito widget is centered.
  /// This will help calculate the centerOffset.
  final bool isCentered;

  /// Start point of the Circulito widget.
  ///
  /// Could be: `top`, `right`, `bottom`, or `left`.
  final StartPoint startPoint;

  /// Direction of the Circulito widget.
  ///
  /// Could be: `clockwise` or `counterClockwise`
  final CirculitoDirection direction;

  /// Type of value of the section.
  ///
  /// Could be: `percentage` or `amount`
  final SectionValueType sectionValueType;

  /// Stroke cap of the Circulito widget.
  ///
  /// Could be: `butt` or `round`
  final CirculitoStrokeCap strokeCap;

  /// Index of the selected section. Usually the hovered section.
  ///
  /// If there is no section selected, this must be -1.
  ///
  /// If the background is selected, this must be -2.
  final int selectedIndex;

  /// Background of the Circulito widget.
  ///
  /// If this is null, the background will not be drawn.
  final CirculitoBackground? background;

  /// List of animations for each section.
  ///
  /// If this is null, the sections will not be animated.
  final List<Animation<double>>? sectionValues;

  /// Create a CustomPainter to draw the Circulito widget.
  ///
  /// Shouldn't be used directly. Use [Circulito] instead.
  CirculitoPainter({
    required this.maxsize,
    required this.sections,
    required this.strokeCap,
    required this.isCentered,
    required this.strokeWidth,
    required this.startPoint,
    required this.direction,
    required this.sectionValueType,
    required this.selectedIndex,
    this.background,
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
    ///
    /// [percentage] between 0 and 1. Full circle is 1.
    /// [decoration] to use in this Arc Draw. (color or gradient)
    /// [index] of the section to draw. Nothing is -1 and background is -2.
    ///
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

      if (index == selectedIndex) {
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

      // Shadow implementation
      // final paint2 = Paint()
      //   ..style = PaintingStyle.stroke
      //   ..strokeWidth = customStrokeWidth
      //   ..strokeCap = flutterStrokeCap
      //   ..color = Colors.black.withOpacity(.2)
      //   ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
      // canvas.drawArc(rect, startAngle, sweepAngle, false, paint2);

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
