import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:circulito/circulito.dart';

import '../widgets/no_space_widget.dart';

class CountDown extends StatefulWidget {
  const CountDown({super.key});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  static const int _durationInSeconds = 10;

  final _padding = 40.0;
  final _maxSize = 400.0;
  final _strokeWidth = 36.0;
  final _colors = [
    Colors.greenAccent,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.redAccent
  ];

  var _textNumber = _durationInSeconds;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenMinSize = min(screenSize.width, screenSize.height) - _padding;
    final size = min(_maxSize, screenMinSize);

    if (size < 250.0) {
      return const NoSpaceWidget();
    }

    return Circulito(
        strokeWidth: _strokeWidth,
        animation: CirculitoAnimation(
          duration: _durationInSeconds * 1000,
          curve: Curves.linear,
        ),
        sections: [
          CirculitoSection(
            value: 1,
            decoration: CirculitoDecoration.fromColor(_getColor()),
          )
        ],
        maxSize: size,
        child: Text(
          '$_textNumber',
          style: Theme.of(context).textTheme.displayLarge,
        ));
  }

  /// Returns the color based on the [_textNumber].
  Color _getColor() {
    switch (_textNumber) {
      case >= 8:
        return _colors[0];
      case >= 5:
        return _colors[1];
      case >= 2:
        return _colors[2];
      default:
        return _colors[3];
    }
  }

  /// Countdown timer.
  void _startTimer() async {
    if (_textNumber < 0) {
      return;
    }

    for (var i = _textNumber; i >= 0; i--) {
      if (mounted) setState(() => _textNumber = i);
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
