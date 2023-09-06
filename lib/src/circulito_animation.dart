import 'package:flutter/material.dart';

/// Animation to the drawing of sections.
class CirculitoAnimation {
  /// The duration of the animation in milliseconds.
  ///
  /// Defaults to `500`.
  final int duration;

  /// The curve of the animation.
  ///
  /// Defaults to `Curves.easeInOut`.
  final Curve curve;

  /// Creates an animation to the drawing of sections.
  CirculitoAnimation({
    this.duration = 500,
    this.curve = Curves.decelerate,
  });
}
