import 'package:flutter/material.dart';

/// The shadow to be painted behind the wheel or behind each section.
///
/// This shadow is painted by the [CirculitoPainter] class.
///
/// [CirculitoShadow] is used by [CirculitoDecoration].
class CirculitoShadow {
  /// The style of the shadow.
  ///
  /// Defaults to `BlurStyle.normal`.
  final BlurStyle blurStyle;

  /// The color of the shadow.
  ///
  /// Defaults to `Colors.grey`.
  final Color color;

  /// The spreading value of the shadow.
  ///
  /// Defaults to `8.0`.
  final double spreading;

  /// Creates a shadow to be painted behind the wheel or behind each section.
  const CirculitoShadow({
    this.blurStyle = BlurStyle.normal,
    this.color = Colors.grey,
    this.spreading = 8.0,
  });
}
