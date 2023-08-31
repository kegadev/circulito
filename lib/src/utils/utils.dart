library utils;

import 'dart:math';

part 'direction.dart';
part 'start_point.dart';
part 'section_value_type.dart';
part 'circulito_stroke_cap.dart';

/// Returns the start angle to draw the wheel from the [startPoint]
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
