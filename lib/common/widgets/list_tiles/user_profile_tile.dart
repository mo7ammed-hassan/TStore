import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_list_tile.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/pages/profile_page.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/user_profile_image.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.status == UserStatus.loading) {
          return const ShimmerListTile();
        }

        if (state.status == UserStatus.success) {
          switch (state.action) {
            case UserAction.fetch:
              return _userTile(state, context);
            case UserAction.update:
              return _userTile(state, context);
            case UserAction.logout:
              return _userTile(state, context);
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  ListTile _userTile(UserState state, BuildContext context) {
    return ListTile(
      leading: FittedBox(
        child: UserProfileImage(
          width: 45,
          height: 45,
          image: state.user?.profilePicture,
        ),
      ),
      title: ResponsiveText(
        '${state.user?.firstName} ${state.user?.lastName}',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.white, fontSize: 16),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: ResponsiveText(
        state.user?.userEmail ?? '',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.white, fontSize: 13.5),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        onPressed: () {
          context.pushPage(ProfilePage(userData: state.user));
        },
        icon: Icon(
          Iconsax.edit,
          size: context.horzSize(22),
          color: AppColors.white,
        ),
      ),
    );
  }
}
