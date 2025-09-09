import 'package:flutter/material.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class ResponsiveGap extends StatelessWidget {
  final double size;
  final Axis axis;

  const ResponsiveGap._({required this.size, required this.axis});

  factory ResponsiveGap.vertical(double height) {
    return ResponsiveGap._(size: height, axis: Axis.vertical);
  }

  factory ResponsiveGap.horizontal(double width) {
    return ResponsiveGap._(size: width, axis: Axis.horizontal);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          axis == Axis.vertical ? getResponsiveSize(context, axis, size) : null,
      width: axis == Axis.horizontal
          ? getResponsiveSize(context, axis, size)
          : null,
    );
  }
}
