import 'package:flutter/material.dart';

/// The sections to be painted
///
/// Each section has a value and a color.
class CirculitoSection {
  final Color color;
  final double value;
  final Color? hoverColor;
  final void Function()? onTap;
  final void Function()? onHover;
  final double hoverStrokeMultiplier;

  CirculitoSection({
    required this.color,
    required this.value,
    this.hoverColor,
    this.onTap,
    this.onHover,
    this.hoverStrokeMultiplier = 1.1,
  }) : assert((value > 0.0), 'Value can not be negative or zero.');
}
