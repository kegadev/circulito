part of '../../circulito.dart';

/// Wraps the main widget and the child widget. Also handles the hover events.
// ignore: must_be_immutable
class _WrappedCirculito extends StatefulWidget {
  final CirculitoDirection direction;
  final StreamController<int> hoveredIndexController;
  final bool isCentered;
  final Widget mainWidget;
  final double maxsize;
  final List<CirculitoSection> sections;
  final SectionValueType sectionValueType;
  final StartPoint startPoint;
  final void Function()? onHoverExit;
  final double strokeWidth;
  final ChildStackingOrder? childStackingOrder;
  double sizeToDraw;
  bool isInfiniteSizedParent;

  final CirculitoBackground? background;
  final double? padding;
  final Widget? child;

  _WrappedCirculito({
    super.key,
    required this.childStackingOrder,
    required this.direction,
    required this.hoveredIndexController,
    required this.isCentered,
    required this.isInfiniteSizedParent,
    required this.mainWidget,
    required this.maxsize,
    required this.sections,
    required this.sectionValueType,
    required this.sizeToDraw,
    required this.startPoint,
    required this.strokeWidth,
    required this.onHoverExit,
    this.background,
    this.padding,
    this.child,
  });

  @override
  State<_WrappedCirculito> createState() => _WrappedCirculitoState();
}

class _WrappedCirculitoState extends State<_WrappedCirculito> {
  /// `Hover` selected Index.
  ///
  /// This avoid repaints when the widget is rebuilt when the parent
  /// widget is rebuilt. Also this is the reason why this class is statefull.
  /// This ensure many Circulito Widgets can be used at the same time.
  var _selectedIndex = -1;

  /// This help detect section tap on mobile devices where hover is not allowed.
  late final bool _isMobile;

  @override
  void initState() {
    _isMobile = Platform.isIOS || Platform.isAndroid;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isNothingSelected = _selectedIndex == -1;
    final canTap = !isNothingSelected || _isMobile;

    Widget wrappedMainWidget = SizedBox(
      width: widget.sizeToDraw,
      height: widget.sizeToDraw,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapCancel: _onTapCancel,
        onTap: canTap ? _onTap : null,
        child: MouseRegion(
          onHover: _onPointerHover,
          onExit: _onPointerExit,
          cursor: _getCursor(_selectedIndex),
          child: widget.mainWidget,
        ),
      ),
    );

    // Return only the main widget if there is no child.
    if (widget.child == null) return wrappedMainWidget;

    final type = widget.child!.runtimeType;

    Widget childToShow = type == Circulito
        ? SizedBox(
            width: min(widget.maxsize, widget.sizeToDraw),
            height: min(widget.maxsize, widget.sizeToDraw),
            child: widget.child,
          )
        : widget.child!;

    // Center when the parent has fixed size.
    if (!widget.isInfiniteSizedParent) {
      childToShow = Center(child: childToShow);
    }

    final hitTestBehavior = isNothingSelected
        ? HitTestBehavior.translucent
        : HitTestBehavior.opaque;

    wrappedMainWidget = SizedBox(
      width: widget.sizeToDraw,
      height: widget.sizeToDraw,
      child: wrappedMainWidget,
    );

    if (widget.childStackingOrder == ChildStackingOrder.behindParent) {
      /// Wrap the `wrappedMainWidget` with a MouseRegion to allow
      /// interaction with the `child` widget.
      wrappedMainWidget = MouseRegion(
        opaque: false,
        hitTestBehavior: hitTestBehavior,
        child: wrappedMainWidget,
      );
    } else {
      /// Wrap the `childToShow` with a MouseRegion to allow
      /// interaction with the `wrappedMainWidget` widget.
      childToShow = MouseRegion(
        opaque: false,
        hitTestBehavior: hitTestBehavior,
        child: childToShow,
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: widget.childStackingOrder == ChildStackingOrder.behindParent
          ? [childToShow, wrappedMainWidget]
          : [wrappedMainWidget, childToShow],
    );
  }

  /// Handles the selection event.
  ///
  /// Only update stream if the section has changed.
  void _doSelection(int sectionIndex) {
    if (sectionIndex != _selectedIndex) {
      setState(() => _selectedIndex = sectionIndex);
      widget.hoveredIndexController.add(sectionIndex);

      // Nothing selected.
      if (_selectedIndex == -1) return;

      // on Hover callback.
      _selectedIndex == -2
          ? widget.background?.onHover?.call()
          : widget.sections[_selectedIndex].onHover?.call();
    }
  }

  /// Returns the cursor to be shown.
  ///
  /// If the hovered index is -1, returns [MouseCursor.defer] which
  /// means the cursor is the default.
  ///
  /// If the hovered section has an `onTap` callback, returns
  /// [SystemMouseCursors.click].
  MouseCursor _getCursor(int hoveredIndex) {
    // This as default because it is more often called and more efficient.
    if (hoveredIndex == -1) return MouseCursor.defer;

    if (hoveredIndex == -2 && widget.background?.onTap != null ||
        hoveredIndex >= 0 && widget.sections[hoveredIndex].onTap != null) {
      return SystemMouseCursors.click;
    }

    return MouseCursor.defer;
  }

  /// Handles the Tap down event.
  void _onTapDown(TapDownDetails details) {
    if (_isMobile) _onCheckSection(details.localPosition);
  }

  /// Handles the cancel of the tap.
  void _onTapCancel() => _removeSelection();

  /// Handles the hover event.
  void _onPointerHover(PointerHoverEvent event) {
    _onCheckSection(event.localPosition);
  }

  /// Handles the exit event.
  void _onPointerExit(PointerExitEvent event) => _removeSelection();

  /// Handles the position of the hover or the tap down to detect
  /// which section should be selected when clicked.
  void _onCheckSection(Offset localPosition) {
    final hoverPosition = localPosition;
    final halfSizeToDraw = widget.sizeToDraw / 2;
    final centerOffset = Offset(halfSizeToDraw, halfSizeToDraw);

    /// Get distance from center to approximate the hover position.
    final distance = Utils.getHoverDistanceFromCenter(
      hoverPosition,
      centerOffset,
    );

    final diameter = min(widget.maxsize, widget.sizeToDraw) / 2;
    final paddingValue = widget.padding ?? 0.0;

    /// If the hover position is too much inside the wheel,
    /// or too much outside the wheel, remove selection.
    if (distance <= ((diameter - widget.strokeWidth) - paddingValue) ||
        distance >= (diameter - paddingValue)) {
      _removeSelection();
      return;
    }

    final angle = Utils.calculateHoverAngle(
      hoverPosition,
      centerOffset,
      halfSizeToDraw,
      CirculitoDirection.clockwise,
      widget.startPoint,
    );

    final sectionIndex = Utils.determineHoverSection(
        angle, widget.sections, widget.sectionValueType);

    _doSelection(sectionIndex);
  }

  /// Handles the tap event.
  void _onTap() {
    if (_selectedIndex == -2) {
      widget.background?.onTap?.call();
    } else if (_selectedIndex != -1) {
      final section = widget.sections[_selectedIndex];
      if (section.onTap != null) {
        section.onTap!();
      }
    }
  }

  /// Removes the selection reseting index.
  void _removeSelection() {
    if (_selectedIndex != -1) {
      widget.onHoverExit?.call();
      setState(() => _selectedIndex = -1);
      widget.hoveredIndexController.add(_selectedIndex);
    }
  }
}
