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

  /// Whether the widget should be centered or not inside the parent widget.
  final bool isCentered;

  /// The maximum size the widget can grow on screen.
  ///
  /// If any of the sizes (width or height) of the parent widget are smaller
  /// than this size, the widget will be shrinked to fit the parent.
  final double? maxSize;

  /// Determines the shape of the stroke endings.
  ///
  /// Could be `Butt` or `Round`. Default to `Round`.
  final CirculitoStrokeCap strokeCap;

  /// The background color of the wheel to be painted.
  ///
  /// If null, no background will be painted.
  final Color? backgroundColor;

  /// The padding to be applied to the widget.
  /// If null, no padding will be applied.
  final EdgeInsets? padding;

  const Circulito({
    super.key,
    required this.sections,
    this.maxSize,
    this.padding,
    this.backgroundColor,
    this.strokeWidth = 20,
    this.isCentered = true,
    this.strokeCap = CirculitoStrokeCap.round,
  });

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = CustomPaint(
      painter: CirculitoPainter(
        maxsize: maxSize,
        sections: sections,
        strokeCap: strokeCap,
        isCentered: isCentered,
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
      ),
    );

    if (padding != null) {
      mainWidget = Padding(padding: padding!, child: mainWidget);
    }

    return mainWidget;
  }
}
