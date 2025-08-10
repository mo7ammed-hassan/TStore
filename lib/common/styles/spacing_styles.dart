import 'package:flutter/rendering.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TSpacingStyles {
  TSpacingStyles._();

  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: TSizes.appBarHeight,
    left: TSizes.defaultSpace / 2,
    right: TSizes.defaultSpace / 2,
    bottom: TSizes.defaultSpace,
  );
}
