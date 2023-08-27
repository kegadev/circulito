import 'package:flutter/material.dart';

import 'src/circulito_painter.dart';
import 'src/circulito_section.dart';
import 'src/circulito_stroke_cap.dart';

export 'src/circulito_section.dart';
export 'src/circulito_stroke_cap.dart';

class Circulito extends StatelessWidget {
  /// The sections to be painted
  final List<CirculitoSection> sections;

  /// The width of the stroke.
  final double strokeWidth;

  /// The actual size of the widget will be the double of the radius.
  final double? radius;

  /// Determines the shape of the stroke endings.
  ///
  /// Could be `Butt` or `Round`. Default to `Round`.
  final CirculitoStrokeCap strokeCap;

  // The background color of the widget.
  //
  // If null, no background will be painted.
  // If not null, a background will be painted with the specified color.
  final Color? backgroundColor;

  const Circulito({
    super.key,
    required this.sections,
    this.radius,
    this.strokeWidth = 20,
    this.backgroundColor,
    this.strokeCap = CirculitoStrokeCap.round,
  });

  @override
  Widget build(BuildContext context) {
    final radius = this.radius ?? double.infinity - 20;

    return Center(
      child: SizedBox(
        width: radius,
        height: radius,
        child: CustomPaint(
          painter: CirculitoPainter(
            sections: sections,
            strokeCap: strokeCap,
            strokeWidth: strokeWidth,
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );
  }
}
