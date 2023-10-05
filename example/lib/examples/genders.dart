import 'dart:math';

import 'package:flutter/material.dart';

import 'package:example/widgets/no_space_widget.dart';

import 'package:circulito/circulito.dart';

class Genders extends StatefulWidget {
  const Genders({super.key});

  @override
  State<Genders> createState() => _GendersState();
}

class _GendersState extends State<Genders> {
  static const _defaultText = 'Genders';

  final _circulitoKey = GlobalKey();
  final _femalePercentage = 0.495;
  final _malePercentage = 0.415;
  final _maxSize = 400.0;
  final _padding = 40.0;

  var _text = _defaultText;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenMinSize = min(screenSize.width, screenSize.height) - _padding;
    final size = min(_maxSize, screenMinSize);

    if (size < 250.0) {
      return const NoSpaceWidget();
    }

    return _genders(size);
  }

  Circulito _genders(double maxSize) {
    final animation = CirculitoAnimation(
      duration: 1000,
      curve: Curves.easeInOut,
    );

    final background = CirculitoBackground(
      onHover: () => _changeChildText('Not defined.'),
      decoration: const CirculitoDecoration.fromColor(
        Colors.grey,
        hoverColor: Colors.grey,
        shadow: CirculitoShadow(),
      ),
    );

    final child = Text(
      _text,
      style: const TextStyle(fontSize: 24.0),
    );

    return Circulito(
      maxSize: maxSize,
      strokeWidth: 70.0,
      key: _circulitoKey,
      animation: animation,
      background: background,
      strokeCap: CirculitoStrokeCap.butt,
      direction: CirculitoDirection.clockwise,
      sections: [_maleSection(), _femaleSection()],
      sectionValueType: SectionValueType.percentage,
      onHoverExit: () => _changeChildText(_defaultText),
      childStackingOrder: ChildStackingOrder.behindParent,
      child: child,
    );
  }

  /// Changes the text of the child widget.
  void _changeChildText(String text) {
    if (!mounted) return;
    setState(() => _text = text);
  }

  /// Switches the text of the child widget.
  void _switchText(String defaultText, double percentage) {
    if (!mounted) return;
    _text = _text == defaultText ? "${percentage * 100}%" : defaultText;
    setState(() {});
  }

  CirculitoSection _maleSection() {
    return CirculitoSection(
      value: _malePercentage,
      onHover: () => _changeChildText('Male'),
      onTap: () => _switchText("Male", _malePercentage),
      decoration: const CirculitoDecoration.fromGradient(
        LinearGradient(colors: [
          Color(0xFF17EAD9),
          Color(0xFF6078EA),
        ]),
        hoverGradient: LinearGradient(colors: [
          Colors.lightBlueAccent,
          Colors.blueAccent,
        ]),
        // hoverColor: Colors.blueAccent,
      ),
    );
  }

  CirculitoSection _femaleSection() {
    return CirculitoSection(
      value: _femalePercentage,
      onHover: () => _changeChildText('Female'),
      onTap: () => _switchText("Female", _femalePercentage),
      decoration: const CirculitoDecoration.fromGradient(
        LinearGradient(colors: [Color(0XFFF54EA2), Color(0xFFFF7676)]),
        hoverGradient: LinearGradient(colors: [
          Colors.pink,
          Colors.pinkAccent,
        ]),
      ),
    );
  }
}
