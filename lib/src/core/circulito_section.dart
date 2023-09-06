import 'package:circulito/circulito.dart';

/// The sections to be painted
///
/// Each section has a value and a color.
class CirculitoSection {
  /// The value of the section.
  ///
  /// If [sectionValueType] is [SectionValueType.percentage], the value must
  /// be between `0.0` and `1.0`.
  ///
  /// If [sectionValueType] is [SectionValueType.amount], the value must be
  /// greater than `0.0`.
  final double value;

  /// The decoration of a section or background in the Circulito widget.
  ///
  /// This decoration can contain either a solid `color` or a `gradient`. Users
  /// should instantiate it using one of the following constructors:
  /// - [CirculitoDecoration.fromColor] for a solid color.
  /// - [CirculitoDecoration.fromGradient] for a gradient.
  ///
  /// Additionally, this decoration supports hover effects, which can be defined
  /// using `hoverColor` or `hoverGradient`, depending on the constructor used.
  final CirculitoDecoration decoration;

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
    required this.value,
    required this.decoration,
    this.onTap,
    this.onHover,
    this.hoverStrokeMultiplier = 1.1,
  }) : assert((value >= 0.0), 'Value can not be negative.');
}
