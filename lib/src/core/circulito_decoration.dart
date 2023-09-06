import 'package:flutter/material.dart';

import '../enums/enums.dart';

class CirculitoDecoration {
  final Color? color;
  final DecorationType type;
  final Color? hoverColor;
  final Gradient? gradient;
  final Gradient? hoverGradient;

  CirculitoDecoration.fromColor(this.color, {this.hoverColor})
      : type = DecorationType.color,
        gradient = null,
        hoverGradient = null;

  CirculitoDecoration.fromGradient(this.gradient, {this.hoverGradient})
      : type = DecorationType.gradient,
        color = null,
        hoverColor = null;
}
