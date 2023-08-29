import 'dart:math';

/// The start point to draw the wheel.
///
/// Could be `top`, `bottom`, `left` or `right`.
enum StartPoint {
  top,
  bottom,
  left,
  right,
}

/// Returns the start angle to draw the wheel.
double getStartAngle(StartPoint startPoint) {
  switch (startPoint) {
    case StartPoint.top:
      return -pi / 2;
    case StartPoint.bottom:
      return pi / 2;
    case StartPoint.left:
      return pi;
    case StartPoint.right:
      return 0;
  }
}
