library utils;

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

/// Utility class.
abstract class Utils {
  /// Returns the start angle to draw the wheel from the [startPoint]
  static double getStartAngle(StartPoint startPoint) {
    switch (startPoint) {
      case StartPoint.top:
        return pi * 1.5;
      // return -pi / 2;
      case StartPoint.bottom:
        return pi / 2;
      case StartPoint.left:
        return pi;
      case StartPoint.right:
        return 0;
    }
  }

  /// Returns the total (sum) value of all sections.
  ///
  /// Must be used when types are [SectionValueType.amount].
  static double getSectionsTotalValue(sections) {
    return sections.fold(0.0, (sum, section) => sum + section.value);
  }

  /// Returns the distance from the center of the wheel to the [hoverPosition].
  static double getHoverDistanceFromCenter(
      Offset hoverPosition, Offset centerOffset) {
    return sqrt(pow(hoverPosition.dx - centerOffset.dx, 2) +
        pow(hoverPosition.dy - centerOffset.dy, 2));
  }

  /// Returns the angle in radians between the [tapPosition] and the center of
  /// the wheel.
  static double calculateHoverAngle(Offset tapPosition, Offset centerOffset,
      double radius, CirculitoDirection direction, StartPoint startPoint) {
    tapPosition - centerOffset;
    final dx = tapPosition.dx - centerOffset.dx;
    final dy = tapPosition.dy - centerOffset.dy;

    var radians = atan2(dy, dx);
    if (direction == CirculitoDirection.counterClockwise) radians = -radians;

    radians = truncateRadiansAngle(radians);
    radians -= getStartAngle(startPoint);
    return truncateRadiansAngle(radians);
  }

  /// Keep the angle in radians between 0 and 2 * pi.
  static double truncateRadiansAngle(double angle) {
    if (angle < 0) {
      angle = angle + (pi * 2);
    } else if (angle > (pi * 2)) {
      angle = angle - (pi * 2);
    }
    return angle;
  }

  /// Returns the index of the section that is being hovered.
  ///
  /// Returns `-1` if no section is being hovered.
  static int determineHoverSection(
    double angle,
    List<CirculitoSection> sections,
    SectionValueType sectionValueType,
  ) {
    var startAngle = 0.0;

    final valueTotal = sectionValueType == SectionValueType.amount
        ? Utils.getSectionsTotalValue(sections)
        : 1.0; // No need to do calculations on type percentage.

    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      final percentage = sectionValueType == SectionValueType.amount
          ? section.value / valueTotal
          : section.value;
      final sectionAngle = percentage * pi * 2;

      final sectionEndAngle = startAngle + sectionAngle;

      if (angle >= startAngle && (angle <= sectionEndAngle)) {
        // Hovering this section.
        return i;
      }
      startAngle += sectionAngle;
    }

    // No section is being hovered.
    return -1;
  }
}
