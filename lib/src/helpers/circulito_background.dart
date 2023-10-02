import 'package:flutter/material.dart';

import 'helpers.dart';

/// The background to be painted behind the wheel.
class CirculitoBackground {
  /// The decoration of background in the Circulito widget.
  ///
  /// This decoration can contain either a solid `color` or a `gradient`. Users
  /// should instantiate it using one of the following constructors:
  /// - [CirculitoDecoration.fromColor] for a solid color.
  /// - [CirculitoDecoration.fromGradient] for a gradient.
  ///
  /// Additionally, this decoration supports hover effects, which can be defined
  /// using `hoverColor` or `hoverGradient`, depending on the constructor used.
  ///
  /// Defaults to `CirculitoDecoration.fromColor(Colors.grey)`.
  final CirculitoDecoration decoration;

  /// The function to be called when the background is tapped.
  ///
  /// If [onTap] is provided the mouse cursor will change to a pointer when
  /// hovering the background.
  final void Function()? onTap;

  /// The function to be called when the background is hovered.
  final void Function()? onHover;

  /// The multiplier to be applied to the stroke width when the
  /// background is hovered.
  ///
  /// This will make the stroke wider or thinner. The default value is `1.1`
  /// (10% wider).
  final double hoverStrokeMultiplier;

  /// Creates a background to be painted behind the wheel.
  CirculitoBackground({
    this.decoration = const CirculitoDecoration.fromColor(Colors.grey),
    this.onTap,
    this.onHover,
    this.hoverStrokeMultiplier = 1.0,
  });
}
