import 'package:flutter/material.dart';

/// The background to be painted behind the wheel.
class CirculitoBackground {
  /// The color of the background.
  ///
  /// Defaults to `Colors.grey`.
  final Color color;

  /// The color of the background when hovered.
  ///
  /// If no [hoverColor] is provided, the [color] will be used.
  final Color? hoverColor;

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
    this.color = Colors.grey,
    this.hoverColor,
    this.onTap,
    this.onHover,
    this.hoverStrokeMultiplier = 1.0,
  });
}
