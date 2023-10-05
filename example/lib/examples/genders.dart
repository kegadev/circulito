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
  final _maxSize = 400.0;
  final _malePercentage = 0.415;
  final _femalePercentage = 0.495;
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
    return Circulito(
      key: _circulitoKey,
      onHoverExit: () => setState(() => _text = _defaultText),
      animation: CirculitoAnimation(
        duration: 1000,
        curve: Curves.easeInOut,
      ),
      maxSize: maxSize,
      strokeWidth: 70.0,
      childStackingOrder: ChildStackingOrder.behindParent,
      background: CirculitoBackground(
        onHover: () => setState(() => _text = 'Not defined.'),
        decoration: const CirculitoDecoration.fromColor(
          Colors.grey,
          hoverColor: Colors.grey,
          shadow: CirculitoShadow(),
        ),
      ),
      strokeCap: CirculitoStrokeCap.butt,
      direction: CirculitoDirection.clockwise,
      sectionValueType: SectionValueType.percentage,
      sections: [
        // Male percentage.
        CirculitoSection(
          value: _malePercentage,
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
          onHover: () {
            setState(() => _text = 'Male');

            // Do something when mouse over this section.
          },
          onTap: () {
            // Default alert
            setState(() {
              _text = _text == "Male" ? "${_malePercentage * 100}%" : "Male";
            });
            // Do something when mouse tapped this section.
          },
        ),

        // Female percentage.
        CirculitoSection(
          value: _femalePercentage,
          onHover: () => setState(() => _text = "Female"),
          onTap: () {
            setState(() {
              _text =
                  _text == "Female" ? "${_femalePercentage * 100}%" : "Female";
            });
          },
          decoration: const CirculitoDecoration.fromGradient(
            LinearGradient(colors: [Color(0XFFF54EA2), Color(0xFFFF7676)]),
            hoverGradient: LinearGradient(colors: [
              Colors.pink,
              Colors.pinkAccent,
            ]),
          ),
        ),
      ],
      child: Text(
        _text,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }
}
