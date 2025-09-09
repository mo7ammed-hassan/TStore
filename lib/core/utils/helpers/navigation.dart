import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';

extension NavigationX on BuildContext {
  /// Push a new page and clear the entire navigation stack
  void pushAndClearAll(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => page),
      (Route<dynamic> route) => false,
    );
  }

  /// Push a new page but keep the current stack
  void pushAndKeepStack(Widget page) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Replace the current page with a new one (remove current and add new)
  void pushReplacementPage(Widget page) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Pop (remove) the current page
  void popPage() {
    if (Navigator.canPop(this)) {
      Navigator.pop(this);
    }
  }

  /// Push a new page with default Material transition
  void pushPage(Widget page) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Push a new page with container animation (Material motion)
  void pushWithContainerAnimation({
    required Widget page,
    Widget? child,
    Radius? radius,
  }) {
    OpenContainerWrapper(
      nextScreen: page,
      radius: radius ?? const Radius.circular(15),
      child: child ?? const SizedBox.shrink(),
    );
  }

  /// Push a new page with scale (zoom-in) animation
  void pushWithScaleAnimation(Widget page) {
    Navigator.push(
      this,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween(begin: 0.3, end: 1.0).animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}
