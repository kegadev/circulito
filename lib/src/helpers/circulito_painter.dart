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

      // Shadow implementation.
      var shadow = decoration.shadow;
      if (shadow != null) {
        final shadowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = customStrokeWidth
          ..strokeCap = flutterStrokeCap
          ..color = shadow.color
          ..maskFilter = MaskFilter.blur(shadow.blurStyle, shadow.spreading);

        canvas.drawArc(rect, startAngle, sweepAngle, false, shadowPaint);
      }

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

      // Stroke border implementation.
      _strokeBorder(
        decoration: decoration,
        canvas: canvas,
        centerOffset: centerOffset,
        radius: radius,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        strokeCap: flutterStrokeCap,
        customStrokeWidth: customStrokeWidth,
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

  /// Draws the stroke border of a section or background.
  ///
  /// In order to draw the silloute of the stroke, this method draws two
  /// arcs and two lines if the [strokeCap] is `StrokeCap.butt`. If the
  /// [strokeCap] is `StrokeCap.round`, this method draws 4 arcs total.
  void _strokeBorder({
    required CirculitoDecoration decoration,
    required Canvas canvas,
    required Offset centerOffset,
    required double radius,
    required double startAngle,
    required double sweepAngle,
    required StrokeCap strokeCap,
    required double customStrokeWidth,
  }) {
    var border = decoration.border;
    if (border == null) return;

    // Points to direct and move the closing lines or arcs of the border.
    final halfStrokeWidth = customStrokeWidth / 2;
    final innerRadius = radius - halfStrokeWidth;
    final outerRadius = radius + halfStrokeWidth;

    final dx = centerOffset.dx;
    final dy = centerOffset.dy;

    // Starting points of the border, by the startAngle.
    final cosStartAngle = cos(startAngle);
    final sinStartAngle = sin(startAngle);

    final startPoint1 = Offset(
      dx + outerRadius * cosStartAngle, // X
      dy + outerRadius * sinStartAngle, // Y
    );
    final startPoint2 = Offset(
      dx + innerRadius * cosStartAngle, // X
      dy + innerRadius * sinStartAngle, // Y
    );

    // Ending points of the border, by the startAngle + sweepAngle.
    final endAngle = startAngle + sweepAngle;
    final cosEndAngle = cos(endAngle);
    final sinEndAngle = sin(endAngle);

    final endPoint1 = Offset(
      dx + innerRadius * cosEndAngle, // X
      dy + innerRadius * sinEndAngle, // Y
    );
    final endPoint2 = Offset(
      dx + outerRadius * cosEndAngle, // X
      dy + outerRadius * sinEndAngle, // Y
    );

    final path = Path();
    final isStrokeCapRound = strokeCap == StrokeCap.round;

    // [FIRST PART] Outer arc.
    final outerRect = Rect.fromCircle(
      center: centerOffset,
      radius: radius + halfStrokeWidth,
    );

    // Draw outer arc.
    path.addArc(outerRect, startAngle, sweepAngle);

    // [SECOND PART] End closing line or arc.
    if (isStrokeCapRound) {
      var center = (endPoint2 + endPoint1) / 2;
      var rect = Rect.fromCircle(center: center, radius: halfStrokeWidth);
      path.addArc(rect, (startAngle + sweepAngle), pi);
    } else {
      path.moveTo(endPoint1.dx, endPoint1.dy);
      path.lineTo(endPoint2.dx, endPoint2.dy);
      path.close();
    }

    // [THIRD PART] Inner arc.
    final innerRect = Rect.fromCircle(
      center: centerOffset,
      radius: radius - halfStrokeWidth,
    );
    path.addArc(innerRect, startAngle, sweepAngle);

    // [FOURTH PART] Start closing line or arc.
    if (isStrokeCapRound) {
      // Draw start closing arc.
      var center = (startPoint2 + startPoint1) / 2;
      var rect = Rect.fromCircle(center: center, radius: halfStrokeWidth);

      path.addArc(rect, startAngle, -pi);
    } else {
      // Draw start closing line.
      path.moveTo(startPoint2.dx, startPoint2.dy);
      path.lineTo(startPoint1.dx, startPoint1.dy);
      path.close();
    }

    // Painter for the stroke border.
    final strokeBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = border.size
      ..strokeCap = strokeCap
      ..strokeJoin = StrokeJoin.round
      ..color = border.color;

    // Draw the stroke border.
    canvas.drawPath(path, strokeBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
