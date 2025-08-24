import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';

class TSpacingStyles {
  TSpacingStyles._();

  static EdgeInsetsGeometry paddingWithAppBarHeight(BuildContext contex) =>
      contex.responsiveInsets.only(
        top: TSizes.appBarHeight,
        left: TSizes.defaultSpace / 2,
        right: TSizes.defaultSpace / 2,
        bottom: TSizes.defaultSpace,
      );
}
