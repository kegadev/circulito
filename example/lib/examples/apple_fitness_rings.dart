import 'dart:math';

import 'package:flutter/material.dart';

import 'package:example/widgets/no_space_widget.dart';

import 'package:circulito/circulito.dart';

/// This example shows how to create a widget similar to the Apple Fitness.
///
/// The widget is composed of three rings, each one representing a different
/// metric: Movement, Exercise and Stand.
///
/// DISCLAIMER: This doesn't pretent to be an exact replica of the Apple
/// Fitness rings. It is just an example of what can be achieved with
/// `Circulito`.
class AppleFitnessRings extends StatelessWidget {
  /// Creates a widget similar to the Apple Fitness.
  const AppleFitnessRings({super.key});
  final _space = 2.0;
  final _maxSize = 400.0;
  final _strokeWidth = 45.0;
  final _padding = 40.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenMinSize = min(screenSize.width, screenSize.height) - _padding;
    final size = min(_maxSize, screenMinSize);

    /// Ring 3: Stand.
    final ringSmall = _ring(
      level: 2,
      delay: 600,
      maxSize: size,
      value: .65, // 65%
      colors: const [Color(0xFF00fff2), Color(0xFF00ffb7)],
    );

    /// Ring 2: Exercise.
    final ringMedium = _ring(
      level: 1,
      delay: 300,
      maxSize: size,
      value: .75, // 75%
      child: ringSmall,
      colors: const [Color(0xFFa4ff35), Color(0xFFd4ff0d)],
    );

    /// Ring 1: Movement.
    final ringBig = _ring(
      level: 0,
      maxSize: size,
      value: .92, // 92%
      child: ringMedium,
      colors: const [Color(0xFFFD0050), Color(0xFFfd297a)],
    );

    return ringBig;
  }

  /// Creates a ring.
  ///
  /// [value] is the percentage of the ring to be filled.
  /// [level] is the level of the ring. The bigger the level, the smaller the ring.
  /// [colors] are the colors of the ring.
  /// [delay] is the delay of the animation.
  /// [child] is the child widget to be placed inside the ring.
  Widget _ring({
    required double value,
    required int level,
    required List<Color> colors,
    required maxSize,
    int delay = 0,
    Widget? child,
  }) {
    final background = CirculitoBackground(
      decoration: CirculitoDecoration.fromGradient(
        LinearGradient(
          colors: colors.map((c) => c.withValues(alpha: .5)).toList(),
        ),
      ),
    );

    final section = CirculitoSection(
      value: value,
      hoverStrokeMultiplier: .95,
      // Could be SweepGradient too.
      decoration: CirculitoDecoration.fromGradient(
        LinearGradient(
          colors: colors,
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        shadow: const CirculitoShadow(color: Color(0xFF18181a), spreading: 4),
      ),
    );

    // Calculate the size dinamically.
    maxSize = maxSize - ((_strokeWidth * 2) * level) - _space * level;

    // Error prevention.
    if (maxSize < ((_strokeWidth * 2) + 10.0)) {
      return NoSpaceWidget(color: colors[0]);
    }

    final animation = CirculitoAnimation(
      duration: 1000 + delay,
      curve: Curves.fastOutSlowIn,
    );

    return Circulito(
      maxSize: maxSize,
      sections: [section],
      animation: animation,
      background: background,
      strokeWidth: _strokeWidth,
      child: child,
    );
  }
}
