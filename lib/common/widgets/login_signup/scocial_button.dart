import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class TSocialButton extends StatelessWidget {
  final String socialIcon;
  final void Function()? onPressed;
  const TSocialButton({
    super.key,
    required this.socialIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Image(
          width: context.horzSize(TSizes.iconLg),
          height: context.horzSize(TSizes.iconLg),
          fit: BoxFit.scaleDown,
          image: AssetImage(socialIcon),
        ),
      ),
    );
  }
}
