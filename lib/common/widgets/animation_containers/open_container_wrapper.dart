import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.child,
    required this.nextScreen,
    required this.radius,
    this.closedElevation = 0.5,
  });
  final Widget child;
  final Widget nextScreen;
  final Radius radius;
  final double closedElevation;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return OpenContainer(
      closedElevation: closedElevation,
      closedShape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.all(radius),
      ),
      closedColor: isDark ? Colors.transparent : AppColors.white,
      transitionDuration: const Duration(milliseconds: 800), //850
      closedBuilder: (_, VoidCallback openContainer) {
        return InkWell(onTap: openContainer, child: child);
      },
      openBuilder: (_, __) => nextScreen,
    );
  }
}
