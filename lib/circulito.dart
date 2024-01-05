library circulito;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/enums/enums.dart';
import 'src/helpers/helpers.dart';
import 'src/utils/utils.dart';

export 'src/helpers/helpers.dart';
export 'src/enums/enums.dart';

part 'src/circulito/wrapped_circulito.dart';

/// Circulito is a widget wraps the CirculitoPainter class
/// to be used properly.
class Circulito extends StatefulWidget {
  /// The sections to be painted
  ///
  /// Each section has a percentage and a color.
  final List<CirculitoSection> sections;

  /// The maximum size the widget can grow inside its parent.
  ///
  /// If any of the sizes (width or height) of the parent widget are smaller
  /// than this size, the widget will be shrinked to fit the parent.
  ///
  /// Cannot be lower or equal than zero and lower or equal than [strokeWidth].
  final double maxSize;

  /// The padding to be applied to the widget when the parent widget is
  /// bigger or equal than the widget itself.
  ///
  /// This represent a `EdgeInsets.all(padding)` value.
  ///
  /// If specific padding is needed, use [Padding] widget to wrap `Circulito`.
  final double? padding;

  /// The background of the wheel to be painted.
  ///
  /// If null, no background will be painted.
  final CirculitoBackground? background;

  /// The width of the stroke.
  ///
  /// Cannot be lower or equal than zero and higher than [maxSize].
  final double strokeWidth;

  /// Whether the widget should be centered or not inside the parent widget.
  ///
  /// On parents with infinite sizes like `Column` or `Row`, this property has
  /// no significant effect.
  final bool isCentered;

  /// Determines the shape of the stroke endings.
  ///
  /// Could be `Butt` or `Round`. Default to `Round`.
  final CirculitoStrokeCap strokeCap;

  /// Determines the start point of the wheel.
  ///
  /// Could be `top`, `bottom`, `left` or `right`. Default to `top`.
  final StartPoint startPoint;

  /// Determines the direction of the wheel.
  ///
  /// Could be `clockwise` or `counterClockwise`. Default to `clockwise`.
  final CirculitoDirection direction;

  /// The widget to be shown over the wheel.
  ///
  /// If a `widget` is provided, a `Stack` widget is going to be created and
  /// the [child] widget is going to be placed over the wheel. If no widget
  /// is provided, `Circulito` will be return as it is.
  ///
  /// Easily Center the child wrapping it in a `Center` widget like this:
  /// ```dart
  /// Circulito(
  /// ...
  /// child: Center(child: Text('$value'%)),
  /// )
  /// ```
  final Widget? child;

  /// Determines the type of the value of each section.
  ///
  /// Could be `percentage` or `amount`. Default to `percentage`.
  ///
  /// If [SectionValueType.percentage] is selected, the value of each section
  /// will be interpreted as a percentage of the total value of all sections.
  /// Value must be **between** `0` and `1`. For example:
  /// ```dart
  /// sectionValueType: SectionValueType.percentage,
  /// sections:[
  ///   CirculitoSection(color: Colors.blue, value: 0.45),
  ///   CirculitoSection(color: Colors.pink, value: 0.55),
  /// ]
  /// ```
  ///
  /// If [SectionValueType.amount] is selected, the percentage of the wheel to be painted
  /// is going to be calculated by dividing each value by the sum
  /// of all the values. For example
  /// ```dart
  /// sectionValueType: SectionValueType.amount,
  /// sections:[
  ///   CirculitoSection(color: Colors.blue, value: 450),
  ///   CirculitoSection(color: Colors.pink, value: 550),
  /// ]
  /// ```
  final SectionValueType sectionValueType;

  /// The animation to be applied to the wheel whenever the [sections] change.
  ///
  /// If null, no animation will be applied.
  final CirculitoAnimation? animation;

  /// The order in which a child is stacked relative to the parent.
  ///
  /// Could be `behindParent` or `inFrontOfParent`.
  ///
  /// Sometimes the [child] widget is needed to be placed inside the wheel,
  /// by placing the child behind the wheel, the child will be drawn behind
  /// and prevent
  final ChildStackingOrder? childStackingOrder;

  /// The function to be called when the mouse pointer exits the wheel.
  final void Function()? onHoverExit;
  const Circulito({
    super.key,
    required this.sections,
    required this.maxSize,
    this.child,
    this.padding,
    this.background,
    this.onHoverExit,
    this.strokeWidth = 20,
    this.isCentered = true,
    this.startPoint = StartPoint.top,
    this.direction = CirculitoDirection.clockwise,
    this.strokeCap = CirculitoStrokeCap.round,
    this.childStackingOrder = ChildStackingOrder.inFrontOfParent,
    this.animation,
    this.sectionValueType = SectionValueType.percentage,
  })  : assert(strokeWidth > 0, "[strokeWidth] must be a positive value"),
        assert(maxSize > 0, "[maxSize] must be a positive value"),
        assert(
            maxSize > strokeWidth,
            "[maxSize] cannot be lower or equal than [strokeWidth],"
            "otherwise, nothing will be drawn on screen.");

  @override
  State<Circulito> createState() => _CirculitoState();
}

class _CirculitoState extends State<Circulito>
    with SingleTickerProviderStateMixin {
  /// Controls the hovered index.
  final StreamController<int> hoveredIndexController =
      StreamController<int>.broadcast();

  // Animation variables.
  late AnimationController _animController;
  late List<Animation<double>> animatedSectionValues;
  List<double> previousSectionValues = [];

  // Main widget key.
  late GlobalKey wrappedKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController.
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animation?.duration ?? 500),
    );

    // Initialize the list of Animations for each section.
    animatedSectionValues = widget.sections.map((section) {
      final value = section.value;

      previousSectionValues.add(value);

      return _getAnimation(0.0, value);
    }).toList();

    // Start the animation when the widget is built.
    _animController.forward();
    wrappedKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    final isAnimated = widget.animation != null;

    Widget mainWidget = StreamBuilder<int>(
        stream: hoveredIndexController.stream,
        initialData: -1,
        builder: (_, snapshot) {
          final hoveredIndex = snapshot.data ?? -1;

          /// [PERFORMANCE]
          /// Prevent animation redraws when no animation was provided.
          if (!isAnimated) {
            return CustomPaint(
              painter: CirculitoPainter(
                maxsize: widget.maxSize,
                sections: widget.sections,
                direction: widget.direction,
                strokeCap: widget.strokeCap,
                isCentered: widget.isCentered,
                selectedIndex: hoveredIndex,
                startPoint: widget.startPoint,
                strokeWidth: widget.strokeWidth,
                background: widget.background,
                sectionValueType: widget.sectionValueType,
              ),
            );
          }

          return AnimatedBuilder(
              animation: _animController,
              builder: (_, __) {
                return CustomPaint(
                  /// [PERFORMANCE]
                  /// Couldn't asign the painter to a variable and reuse it
                  /// here because then, no animation was shown.
                  /// This go against DRY principle but is necessary.
                  painter: CirculitoPainter(
                    maxsize: widget.maxSize,
                    sections: widget.sections,
                    direction: widget.direction,
                    strokeCap: widget.strokeCap,
                    isCentered: widget.isCentered,
                    selectedIndex: hoveredIndex,
                    startPoint: widget.startPoint,
                    strokeWidth: widget.strokeWidth,
                    background: widget.background,
                    sectionValueType: widget.sectionValueType,
                    sectionValues: _getAnimationValues(),
                  ),
                );
              });
        });

    if (widget.padding != null) {
      final paddingInset = EdgeInsets.all(widget.padding!);
      mainWidget = Padding(padding: paddingInset, child: mainWidget);
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        final circulitoWidget = _WrappedCirculito(
          key: wrappedKey,
          sizeToDraw: min(maxWidth, maxHeight),
          mainWidget: mainWidget,
          sections: widget.sections,
          isCentered: widget.isCentered,
          onHoverExit: widget.onHoverExit,
          childStackingOrder: widget.childStackingOrder,
          hoveredIndexController: hoveredIndexController,
          isInfiniteSizedParent: false,
          strokeWidth: widget.strokeWidth,
          sectionValueType: widget.sectionValueType,
          maxsize: widget.maxSize,
          startPoint: widget.startPoint,
          direction: widget.direction,
          background: widget.background,
          padding: widget.padding,
          child: widget.child,
        );

        // For fixed sizes, just return the widget.
        if (maxWidth.isFinite && maxHeight.isFinite) {
          return circulitoWidget;
        }

        // For infinite sizes, it is necesary shrink the widget to fit the parent.
        final maxAvailableSize = min(maxWidth, maxHeight);
        final sizeToDraw = min(widget.maxSize, maxAvailableSize);

        // Change properties of the widget to fit the parent.
        circulitoWidget
          ..isInfiniteSizedParent = true
          ..sizeToDraw = sizeToDraw;

        return circulitoWidget;
      },
    );
  }

  /// Returns an animation from a value to another.
  Animation<double> _getAnimation(double begin, double end) {
    _animController.duration =
        Duration(milliseconds: widget.animation?.duration ?? 500);

    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: widget.animation?.curve ?? Curves.decelerate,
      ),
    );
  }

  /// Checks if the animation should be reseted.
  List<Animation<double>> _getAnimationValues() {
    final sections = widget.sections;

    // Only draw again if the sections have changed.
    final canDrawAgain = Utils.areArraysDifferent(
        previousSectionValues, sections.map((e) => e.value).toList());

    if (!canDrawAgain) return animatedSectionValues;

    // Restore values.
    animatedSectionValues = [];

    // Prevent overflow when adding and removing sections.
    previousSectionValues = Utils.truncateList(
      previousSectionValues,
      sections.length,
    ) as List<double>;

    _animController.reset();

    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      final isOutOfRange = i > previousSectionValues.length - 1;
      final previousValue = isOutOfRange ? 0.0 : previousSectionValues[i];

      // New animation.
      final anim = _getAnimation(previousValue, section.value);
      animatedSectionValues.add(anim);

      // Save new values.
      isOutOfRange
          ? previousSectionValues.add(section.value)
          : previousSectionValues[i] = section.value;
    }
    _animController.forward();

    return animatedSectionValues;
  }

  @override
  void dispose() {
    // Close the StreamController when the widget is disposed.
    hoveredIndexController.close();

    _animController.dispose();
    super.dispose();
  }
}
