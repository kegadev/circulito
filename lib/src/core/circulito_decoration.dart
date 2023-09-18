import 'package:flutter/material.dart';

import 'package:circulito/src/core/circulito_shadow.dart';

import '../enums/enums.dart';

/// The decoration of a section or background in the Circulito widget.
///
/// This decoration can contain either a solid `color` or a `gradient`. Users
/// should instantiate it using one of the following constructors:
/// - [CirculitoDecoration.fromColor] for a solid color.
/// - [CirculitoDecoration.fromGradient] for a gradient.
///
/// Additionally, this decoration supports hover effects, which can be defined
/// using `hoverColor` or `hoverGradient`, depending on the constructor used.
class CirculitoDecoration {
  final Color? color;
  final DecorationType type;
  final Color? hoverColor;
  final Gradient? gradient;
  final Gradient? hoverGradient;
  final CirculitoShadow? shadow;

  /// Creates a `decoration` from a solid color. If [hoverColor] is provided, the
  /// section will change to that color when hovered.
  const CirculitoDecoration.fromColor(
    this.color, {
    this.hoverColor,
    this.shadow,
  })  : type = DecorationType.color,
        gradient = null,
        hoverGradient = null;

  /// Creates a `decoration` from a gradient. If [hoverGradient] is provided, the
  /// section will change to that gradient when hovered.
  const CirculitoDecoration.fromGradient(
    this.gradient, {
    this.hoverGradient,
    this.shadow,
  })  : type = DecorationType.gradient,
        color = null,
        hoverColor = null;
}
