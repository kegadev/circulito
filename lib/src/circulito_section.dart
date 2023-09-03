import 'package:flutter/material.dart';

/// The sections to be painted
///
/// Each section has a value and a color.
class CirculitoSection {
  /// The color of the section.
  final Color color;

  /// The value of the section.
  ///
  /// If [sectionValueType] is [SectionValueType.percentage], the value must
  /// be between `0.0` and `1.0`.
  ///
  /// If [sectionValueType] is [SectionValueType.amount], the value must be
  /// greater than `0.0`.
  final double value;

  /// The color of the section when hovered.
  ///
  /// if no [hoverColor] is provided, the [color] will be used.
  final Color? hoverColor;

  /// The function to be called when the section is tapped.
  ///
  /// If [onTap] is provided the mouse cursor will change to a pointer when
  /// hovering the section.
  final void Function()? onTap;

  /// The function to be called when the section is hovered.
  final void Function()? onHover;

  /// The multiplier to be applied to the stroke width when the section is
  /// hovered.
  ///
  /// This will make the stroke wider or thinner.The default value is `1.1`
  /// (10% wider).
  final double hoverStrokeMultiplier;

  /// Creates a section to be painted.
  ///
  /// Each section has a value and a color.
  CirculitoSection({
    required this.color,
    required this.value,
    this.hoverColor,
    this.onTap,
    this.onHover,
    this.hoverStrokeMultiplier = 1.1,
  }) : assert((value > 0.0), 'Value can not be negative or zero.');
}
