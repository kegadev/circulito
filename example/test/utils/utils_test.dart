import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:circulito/circulito.dart';
import 'package:circulito/src/utils/utils.dart';

void main() {
  test('Utils getStartAngle test', () {
    expect(Utils.getStartAngle(StartPoint.top), equals(1.5 * pi));
    expect(Utils.getStartAngle(StartPoint.bottom), equals(0.5 * pi));
    expect(Utils.getStartAngle(StartPoint.left), equals(pi));
    expect(Utils.getStartAngle(StartPoint.right), equals(0));
  });

  test('Utils getSectionsTotalValue test', () {
    final sections = [
      CirculitoSection(
        value: 0.2,
        decoration: const CirculitoDecoration.fromColor(Colors.red),
      ),
      CirculitoSection(
        value: 0.3,
        decoration: const CirculitoDecoration.fromColor(Colors.blue),
      ),
      CirculitoSection(
        value: 0.5,
        decoration: const CirculitoDecoration.fromColor(Colors.green),
      ),
    ];

    expect(Utils.getSectionsTotalValue(sections, SectionValueType.amount),
        equals(1.0));
    expect(Utils.getSectionsTotalValue(sections, SectionValueType.percentage),
        equals(1.0));
    expect(
        Utils.getSectionsTotalValue(
            sections, SectionValueType.percentage, true),
        equals(1.0));
  });

  test('Utils getHoverDistanceFromCenter test', () {
    const hoverPosition = Offset(100, 100);
    const centerOffset = Offset(200, 200);

    expect(Utils.getHoverDistanceFromCenter(hoverPosition, centerOffset),
        equals(141.4213562373095));
  });
}
