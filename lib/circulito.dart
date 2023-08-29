import 'dart:math';

import 'package:flutter/material.dart';

import 'src/circulito_painter.dart';
import 'src/circulito_section.dart';
import 'src/circulito_stroke_cap.dart';

export 'src/circulito_section.dart';
export 'src/circulito_stroke_cap.dart';

class Circulito extends StatelessWidget {
  /// The sections to be painted
  ///
  /// Each section has a percentage and a color.
  final List<CirculitoSection> sections;

  /// The width of the stroke.
  ///
  /// Cannot be lower or equal than zero and higher than [maxSize].
  final double strokeWidth;

  /// Whether the widget should be centered or not inside the parent widget.
  ///
  /// On parents with infinite sizes like `Column` or `Row`, this property has
  /// no significant effect.
  final bool isCentered;

  /// The maximum size the widget can grow inside its parent.
  ///
  /// If any of the sizes (width or height) of the parent widget are smaller
  /// than this size, the widget will be shrinked to fit the parent.
  ///
  /// Cannot be lower or equal than zero and lower or equal than [strokeWidth].
  final double maxSize;

  /// Determines the shape of the stroke endings.
  ///
  /// Could be `Butt` or `Round`. Default to `Round`.
  final CirculitoStrokeCap strokeCap;

  /// The background color of the wheel to be painted.
  ///
  /// If null, no background will be painted.
  final Color? backgroundColor;

  /// The padding to be applied to the widget when the parent widget is
  /// bigger or equal than the widget itself.
  final EdgeInsets? padding;

  const Circulito({
    super.key,
    required this.sections,
    required this.maxSize,
    this.padding,
    this.backgroundColor,
    this.strokeWidth = 20,
    this.isCentered = true,
    this.strokeCap = CirculitoStrokeCap.round,
  })  : assert(strokeWidth > 0, "[strokeWidth] must be a positive value"),
        assert(maxSize > 0, "[maxSize] must be a positive value"),
        assert(
            maxSize > strokeWidth,
            "[maxSize] cannot be lower or equal than [strokeWidth],"
            "otherwise, nothing will be drawn on screen.");

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

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        // For fixed sizes, just return the widget.
        if (maxWidth.isFinite && maxHeight.isFinite) return mainWidget;

        // For infinite sizes, it is necesary shrink the widget to fit the parent.
        final outerStrokeWidth = strokeWidth / 2;
        final maxAvailableSize = min(maxWidth, maxHeight);

        var sizeToDraw = min(maxSize, maxAvailableSize);
        sizeToDraw -= outerStrokeWidth;

        return SizedBox(
          width: sizeToDraw,
          height: sizeToDraw,
          child: mainWidget,
        );
      },
    );

    // return mainWidget;
  }
}
