import 'package:flutter/material.dart';

/// The sections to be painted
///
/// Each section has a value and a color.
class CirculitoSection {
  final Color color;
  final double value;

  CirculitoSection({
    required this.color,
    required this.value,
  }) : assert((value > 0.0), 'Value can not be negative or zero.');
}
