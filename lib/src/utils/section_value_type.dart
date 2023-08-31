part of utils;

/// The type of the value of a section.
enum SectionValueType {
  /// The value of each section will be interpreted as a percentage of the
  /// total value of all sections. value must be between `0` and `1`.
  /// ```dart
  /// [
  ///   CirculitoSection(color: Colors.blue, value: 0.45),
  ///   CirculitoSection(color: Colors.pink, value: 0.55),
  /// ]
  /// ```
  percentage,

  /// Here the percentage of the wheel to be painted is going to be calculated
  /// by dividing the each value by the sum of all the values.
  /// ```dart
  /// [
  ///   CirculitoSection(color: Colors.blue, value: 450),
  ///   CirculitoSection(color: Colors.pink, value: 550),
  /// ]
  /// ```
  amount,
}
