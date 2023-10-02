import 'package:flutter/material.dart';

// The shadow to be painted behind the wheel or behind each section.
class CirculitoBorder {
  /// The color of the border.
  final Color color;

  // The size of the border.
  final double size;

  /// Creates a border to be painted around the wheel or around each section.
  const CirculitoBorder({
    this.color = Colors.black,
    this.size = 4.0,
  });
}
