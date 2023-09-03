import 'package:flutter/material.dart';

class CirculitoBackground {
  final Color color;
  final Color? hoverColor;
  final void Function()? onTap;
  final void Function()? onHover;
  final double hoverStrokeMultiplier;

  CirculitoBackground({
    this.color = Colors.grey,
    this.hoverColor,
    this.onTap,
    this.onHover,
    this.hoverStrokeMultiplier = 1.0,
  });
}
