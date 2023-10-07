import 'dart:math';

import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

import '../widgets/no_space_widget.dart';

class DynamicRing extends StatefulWidget {
  const DynamicRing({super.key});

  @override
  State<DynamicRing> createState() => _DynamicRingState();
}

class _DynamicRingState extends State<DynamicRing> {
  final _padding = 40.0;
  final _maxSize = 400.0;
  final _circulitoKey = GlobalKey();
  final _sectionValues = [0.0, 0.0, 0.0];
  final _colorNames = ['Yellow', 'Blue', 'Red']; // Ecuador 🇪🇨.
  final _colors = [
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.redAccent,
  ];

  var _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenMinSize = min(screenSize.width, screenSize.height) - _padding;
    final size = min(_maxSize, screenMinSize);

    if (size < 250.0) {
      return const NoSpaceWidget();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        _ring(size),
        Positioned(
          top: 20.0,
          child: _resetButton(),
        ),
        Positioned(
          bottom: 20.0,
          child: _buttons(),
        ),
      ],
    );
  }

  /// Creates a button to reset the ring.
  Widget _resetButton() {
    var isResetted = _sectionValues[0] == 0.0 &&
        _sectionValues[1] == 0.0 &&
        _sectionValues[2] == 0.0;

    void reset() {
      setState(() {
        _sectionValues[0] = 0.0;
        _sectionValues[1] = 0.0;
        _sectionValues[2] = 0.0;
      });
    }

    return ElevatedButton(
      onPressed: isResetted ? null : reset,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.refresh),
          SizedBox(width: 10.0),
          Text('Reset', style: TextStyle(fontSize: 16.0)),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }

  /// Creates the buttons to add or remove values from the ring.
  Widget _buttons() {
    const space = SizedBox(width: 16.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_button(0), space, _button(1), space, _button(2)],
    );
  }

  /// Creates a button to add or remove values from the ring.
  Widget _button(int index) {
    final colorName = _colorNames[index];
    final color = _colors[index];

    return SizedBox(
      height: 120.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${_sectionValues[index].truncate()}',
            style: TextStyle(
                fontSize: _selectedIndex == index ? 24.0 : 18.0,
                fontWeight: _selectedIndex == index
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          const SizedBox(height: 10.0),
          Text(colorName,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: _selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal)),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _subButton(
                  color, index, Icons.remove, _sectionValues[index] - 10),
              const SizedBox(width: 10.0),
              _subButton(color, index, Icons.add, _sectionValues[index] + 10),
            ],
          ),
        ],
      ),
    );
  }

  /// Wrapper for the IconButton.
  Widget _subButton(Color color, int index, IconData icon, double newValue) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.black,
        onPressed: newValue < 0 || newValue > 990
            ? null
            : () {
                setState(() {
                  _sectionValues[index] = newValue;
                });
              },
      ),
    );
  }

  /// Creates a ring.
  Widget _ring(double size) {
    final background = CirculitoBackground(
      decoration: const CirculitoDecoration.fromColor(Color(0xFFF1F2F3)),
    );

    var sections = <CirculitoSection>[];

    for (var i = 0; i < _sectionValues.length; i++) {
      if (_sectionValues[i] > 0.0) {
        final section = _section(i);
        sections.add(section);
      }
    }

    final animation = CirculitoAnimation(
      duration: 800,
      curve: Curves.fastOutSlowIn,
      // Other animation style
      // curve: sections.length <= 2 ? Curves.fastOutSlowIn : Curves.elasticOut,
    );

    return Circulito(
      maxSize: size,
      key: _circulitoKey,
      sections: sections,
      onHoverExit: () => setState(() => _selectedIndex = -1),
      strokeCap: CirculitoStrokeCap.butt,
      animation: animation,
      background: background,
      strokeWidth: size / 2,
    );
  }

  /// Creates a section.
  CirculitoSection _section(int index) {
    final totalValue =
        _sectionValues.reduce((value, element) => value + element);
    final value = _sectionValues[index] / totalValue;

    return CirculitoSection(
      value: value,
      onHover: () => setState(() => _selectedIndex = index),
      decoration: CirculitoDecoration.fromColor(_colors[index]),
    );
  }

  /// Simplier way to Create a section:
  /// CONS: The animation is not smooth if the total is changing.
  /// If want to use values then the Circulito Section Value Type
  /// should be SectionValueType.amount
  // CirculitoSection _section(int index) {
  //   return CirculitoSection(
  //     value: _sectionValues[index],
  //     decoration: CirculitoDecoration.fromColor(_colors[index]),
  //   );
  // }
}
