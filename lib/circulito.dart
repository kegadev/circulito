import 'dart:math';

import 'package:flutter/material.dart';

import 'src/circulito_painter.dart';
import 'src/circulito_section.dart';
import 'src/utils/utils.dart';

export 'src/circulito_section.dart';
export 'src/utils/utils.dart';

/// Circulito is a widget wraps the CirculitoPainter class
/// to be used properly.
///
/// Each section has a percentage and a color.
class Circulito extends StatelessWidget {
  /// The sections to be painted
  ///
  /// Each section has a percentage and a color.
  final List<CirculitoSection> sections;

  /// The maximum size the widget can grow inside its parent.
  ///
  /// If any of the sizes (width or height) of the parent widget are smaller
  /// than this size, the widget will be shrinked to fit the parent.
  ///
  /// Cannot be lower or equal than zero and lower or equal than [strokeWidth].
  final double maxSize;

  /// The padding to be applied to the widget when the parent widget is
  /// bigger or equal than the widget itself.
  final EdgeInsets? padding;

  /// The background color of the wheel to be painted.
  ///
  /// If null, no background will be painted.
  final Color? backgroundColor;

  /// The width of the stroke.
  ///
  /// Cannot be lower or equal than zero and higher than [maxSize].
  final double strokeWidth;

  /// Whether the widget should be centered or not inside the parent widget.
  ///
  /// On parents with infinite sizes like `Column` or `Row`, this property has
  /// no significant effect.
  final bool isCentered;

  /// Determines the shape of the stroke endings.
  ///
  /// Could be `Butt` or `Round`. Default to `Round`.
  final CirculitoStrokeCap strokeCap;

  /// Determines the start point of the wheel.
  ///
  /// Could be `top`, `bottom`, `left` or `right`. Default to `top`.
  final StartPoint startPoint;

  /// Determines the direction of the wheel.
  ///
  /// Could be `clockwise` or `counterClockwise`. Default to `clockwise`.
  final CirculitoDirection direction;

  /// The widget to be shown over the wheel.
  ///
  /// If a `widget` is provided, a `Stack` widget is going to be created and
  /// the [child] widget is going to be placed over the wheel. If no widget
  /// is provided, `Circulito` will be return as it is.
  ///
  /// Easily Center the child wrapping it in a `Center` widget like this:
  /// ```dart
  /// Circulito(
  /// ...
  /// child: Center(child: Text('$value'%)),
  /// )
  /// ```
  final Widget? child;

  const Circulito({
    super.key,
    required this.sections,
    required this.maxSize,
    this.child,
    this.padding,
    this.backgroundColor,
    this.strokeWidth = 20,
    this.isCentered = true,
    this.startPoint = StartPoint.top,
    this.direction = CirculitoDirection.clockwise,
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
        startPoint: startPoint,
        strokeWidth: strokeWidth,
        direction: direction,
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
        // if (maxWidth.isFinite && maxHeight.isFinite) return mainWidget;
        if (maxWidth.isFinite && maxHeight.isFinite) {
          return _Circulito(
            sizeToDraw: min(maxWidth, maxHeight),
            mainWidget: mainWidget,
            isCentered: isCentered,
            isInfiniteSizedParent: false,
            maxsize: maxSize,
            child: child,
          );
        }

        // For infinite sizes, it is necesary shrink the widget to fit the parent.
        final outerStrokeWidth = strokeWidth / 2;
        final maxAvailableSize = min(maxWidth, maxHeight);

        var sizeToDraw = min(maxSize, maxAvailableSize);
        sizeToDraw -= outerStrokeWidth;

        return _Circulito(
          sizeToDraw: sizeToDraw,
          mainWidget: mainWidget,
          isCentered: isCentered,
          isInfiniteSizedParent: true,
          maxsize: maxSize,
          child: child,
        );
      },
    );

    // return mainWidget;
  }
}

/// Wraps the main widget and the child widget.
class _Circulito extends StatelessWidget {
  const _Circulito({
    required this.sizeToDraw,
    required this.mainWidget,
    required this.maxsize,
    required this.isCentered,
    required this.isInfiniteSizedParent,
    this.child,
  });

  final double sizeToDraw;
  final Widget mainWidget;
  final double maxsize;
  final bool isCentered;
  final bool isInfiniteSizedParent;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final wrappedMainWidget = SizedBox(
      width: sizeToDraw,
      height: sizeToDraw,
      child: mainWidget,
    );

    if (child == null) return wrappedMainWidget;

    Widget childToSHow = SizedBox(
      width: min(maxsize, sizeToDraw),
      height: min(maxsize, sizeToDraw),
      child: child,
    );

    if (!isInfiniteSizedParent) {
      childToSHow = Center(child: childToSHow);
    }

    return Stack(
      children: [
        SizedBox(
          width: sizeToDraw,
          height: sizeToDraw,
          child: wrappedMainWidget,
        ),
        childToSHow,
      ],
    );
  }
}
