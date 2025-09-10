import 'package:flutter/material.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class SelectionIndicator extends StatelessWidget {
  const SelectionIndicator({super.key, required this.selected});
  final bool selected;
  // constants
  static const _animationDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      width: context.horzSize(24),
      height: context.vertSize(24),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? Colors.transparent : const Color(0xFF007df3),
          width: selected ? 0 : 4,
        ),
        boxShadow: [
          if (selected)
            BoxShadow(
              color: const Color(0xFF007df3).withValues(alpha: 0.4),
              blurRadius: 0,
              offset: const Offset(0, 0),
            )
        ],
      ),
      child: AnimatedContainer(
        duration: _animationDuration,
        width: context.horzSize(12),
        height: context.vertSize(12),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF007df3).withValues(alpha: 0.9)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
