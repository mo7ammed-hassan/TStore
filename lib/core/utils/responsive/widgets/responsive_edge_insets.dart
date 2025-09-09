import 'package:flutter/material.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

/// Extension on [BuildContext] to easily access responsive [EdgeInsets].
///
/// Example:
/// ```dart
/// Padding(
///   padding: context.responsiveInsets.all(16),
///   child: Text("Responsive padding with all sides"),
/// )
/// ```
extension ResponsiveInsetsExtension on BuildContext {
  ResponsiveInsets get responsiveInsets => ResponsiveInsets(this);
}

/// A utility class that provides responsive versions of Flutter's [EdgeInsets].
///
/// Instead of using fixed values for paddings/margins, this class adapts
/// the values based on screen size and orientation using [getResponsiveSize].
///
/// You can use this class directly:
/// ```dart
/// Container(
///   margin: ResponsiveEdgeInsets.all(context, 16),
///   child: Text("Margin with all sides"),
/// );
/// ```
///
/// Or use the [BuildContext] extension for cleaner syntax:
/// ```dart
/// Padding(
///   padding: context.responsiveInsets.symmetric(horizontal: 20, vertical: 12),
///   child: Text("Symmetric padding"),
/// )
/// ```
class ResponsiveEdgeInsets {
  /// Creates [EdgeInsets] where all sides are the same, scaled responsively.
  ///
  /// Example:
  /// ```dart
  /// Padding(
  ///   padding: ResponsiveEdgeInsets.all(context, 16),
  ///   child: Text("All sides padding"),
  /// );
  /// ```
  static EdgeInsets all(
    BuildContext context,
    double value, {
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    return EdgeInsets.all(
      getResponsiveSize(context, null, value,
          minScale: minScale, maxScale: maxScale),
    );
  }

  /// Creates [EdgeInsets] with horizontal and vertical values,
  /// each scaled responsively according to axis.
  ///
  /// Example:
  /// ```dart
  /// Padding(
  ///   padding: ResponsiveEdgeInsets.symmetric(context, horizontal: 20, vertical: 12),
  ///   child: Text("Symmetric padding"),
  /// );
  /// ```
  static EdgeInsets symmetric(
    BuildContext context, {
    double horizontal = 0,
    double vertical = 0,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    return EdgeInsets.symmetric(
      horizontal: getResponsiveSize(context, Axis.horizontal, horizontal,
          minScale: minScale, maxScale: maxScale),
      vertical: getResponsiveSize(context, Axis.vertical, vertical,
          minScale: minScale, maxScale: maxScale),
    );
  }

  /// Creates [EdgeInsets] with individually specified sides,
  /// each scaled responsively.
  ///
  /// Example:
  /// ```dart
  /// Padding(
  ///   padding: ResponsiveEdgeInsets.only(context, left: 24, bottom: 16),
  ///   child: Text("Only left and bottom padding"),
  /// );
  /// ```
  static EdgeInsets only(
    BuildContext context, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    return EdgeInsets.only(
      left: getResponsiveSize(context, Axis.horizontal, left,
          minScale: minScale, maxScale: maxScale),
      top: getResponsiveSize(context, Axis.vertical, top,
          minScale: minScale, maxScale: maxScale),
      right: getResponsiveSize(context, Axis.horizontal, right,
          minScale: minScale, maxScale: maxScale),
      bottom: getResponsiveSize(context, Axis.vertical, bottom,
          minScale: minScale, maxScale: maxScale),
    );
  }

  /// Creates [EdgeInsets] from specific left, top, right and bottom values,
  /// each scaled responsively.
  ///
  /// Example:
  /// ```dart
  /// Padding(
  ///   padding: ResponsiveEdgeInsets.fromLTRB(context, 10, 20, 30, 40),
  ///   child: Text("FromLTRB padding"),
  /// );
  /// ```
  static EdgeInsets fromLTRB(
    BuildContext context,
    double left,
    double top,
    double right,
    double bottom, {
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    return EdgeInsets.fromLTRB(
      getResponsiveSize(context, Axis.horizontal, left,
          minScale: minScale, maxScale: maxScale),
      getResponsiveSize(context, Axis.vertical, top,
          minScale: minScale, maxScale: maxScale),
      getResponsiveSize(context, Axis.horizontal, right,
          minScale: minScale, maxScale: maxScale),
      getResponsiveSize(context, Axis.vertical, bottom,
          minScale: minScale, maxScale: maxScale),
    );
  }
}

/// Private helper class returned by [ResponsiveInsetsExtension].
///
/// Provides the same methods as [ResponsiveEdgeInsets] but with cleaner
/// syntax that doesn’t require passing [BuildContext] manually.
class ResponsiveInsets {
  final BuildContext context;
  const ResponsiveInsets(this.context);

  /// Same as [ResponsiveEdgeInsets.all] but accessed via extension.
  EdgeInsets all(double value, {double minScale = 0.8, double maxScale = 1.2}) {
    return ResponsiveEdgeInsets.all(context, value,
        minScale: minScale, maxScale: maxScale);
  }

  /// Same as [ResponsiveEdgeInsets.symmetric] but accessed via extension.
  EdgeInsets symmetric({
    double horizontal = 0,
    double vertical = 0,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    return ResponsiveEdgeInsets.symmetric(context,
        horizontal: horizontal,
        vertical: vertical,
        minScale: minScale,
        maxScale: maxScale);
  }

  /// Same as [ResponsiveEdgeInsets.only] but accessed via extension.
  EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    return ResponsiveEdgeInsets.only(context,
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        minScale: minScale,
        maxScale: maxScale);
  }

  /// Same as [ResponsiveEdgeInsets.fromLTRB] but accessed via extension.
  EdgeInsets fromLTRB(
    double left,
    double top,
    double right,
    double bottom, {
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    return ResponsiveEdgeInsets.fromLTRB(context, left, top, right, bottom,
        minScale: minScale, maxScale: maxScale);
  }
}
