import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/pages/cart_page.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/device/device_utlity.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.responsiveInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        title: _buildTitle(context),
        automaticallyImplyLeading: false,
        actions: [
          TCartCounterIcon(
            onPressed: () => context.pushPage(const CartPage()),
            iconColor: AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          TTexts.homeAppbarTitle,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .apply(color: AppColors.grey),
        ),
        _buildUserName(context),
      ],
    );
  }

  Widget _buildUserName(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.status == UserStatus.loading) {
          return _loadingWidget(context);
        }

        if (state.status == UserStatus.success) {
          switch (state.action) {
            case UserAction.fetch:
              return _userNameWidget(state, context);
            case UserAction.update:
              return _userNameWidget(state, context);
            case UserAction.logout:
              return _userNameWidget(state, context);
          }
        }

        return const SizedBox.shrink();
      },
    );
  }

  ResponsiveText _userNameWidget(UserState state, BuildContext context) {
    return ResponsiveText(
      '${state.user?.firstName} ${state.user?.lastName}',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.grey,
          ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return ShimmerWidget(
      height: 10,
      margin: const EdgeInsets.only(top: 3),
      width: TDeviceUtils.getScreenWidth(context) * 0.4,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
