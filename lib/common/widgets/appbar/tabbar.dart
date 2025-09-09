import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/device/device_utlity.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorColor: AppColors.primary,
      unselectedLabelColor: AppColors.darkGrey,
      labelColor: HelperFunctions.isDarkMode(context)
          ? AppColors.white
          : AppColors.primary,
      tabs: tabs,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
