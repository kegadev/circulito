import 'package:flutter/material.dart';

class NoSpaceWidget extends StatelessWidget {
  final Color? color;

  const NoSpaceWidget({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'NOT ENOUGH SPACE',
      child: Icon(
        Icons.error,
        color: color ?? Theme.of(context).colorScheme.error,
      ),
    );
  }
}
