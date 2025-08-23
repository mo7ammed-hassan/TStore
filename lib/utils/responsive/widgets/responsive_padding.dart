import 'package:flutter/material.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';

class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding._({
    super.key,
    required this.child,
    required this.paddingBuilder,
  });
  final Widget child;

  /// ---> builder function:
  final EdgeInsets Function(BuildContext context) paddingBuilder;

  /// --- All sides Padding ----
  factory ResponsivePadding.all(
    double value, {
    Key? key,
    required Widget child,
  }) {
    return ResponsivePadding._(
      key: key,
      paddingBuilder: (context) =>
          EdgeInsets.all(getResponsiveSize(context, null, value)),
      child: child,
    );
  }

  /// --- Symmetric padding (horizontal & vertical) ---
  factory ResponsivePadding.symmetric({
    Key? key,
    double horizontal = 0,
    double vertical = 0,
    required Widget child,
  }) {
    return ResponsivePadding._(
      key: key,
      paddingBuilder: (context) => EdgeInsets.symmetric(
        horizontal: getResponsiveSize(context, Axis.horizontal, horizontal),
        vertical: getResponsiveSize(context, Axis.horizontal, vertical),
      ),
      child: child,
    );
  }

  /// --- Only padding (specify each side individually) ---
  factory ResponsivePadding.only({
    Key? key,
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
    required Widget child,
  }) {
    return ResponsivePadding._(
      key: key,
      paddingBuilder: (context) => EdgeInsets.only(
        left: getResponsiveSize(context, Axis.horizontal, left),
        top: getResponsiveSize(context, Axis.vertical, top),
        right: getResponsiveSize(context, Axis.horizontal, right),
        bottom: getResponsiveSize(context, Axis.vertical, bottom),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingBuilder(context),
      child: child,
    );
  }
}
