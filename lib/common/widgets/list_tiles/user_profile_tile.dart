import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_list_tile.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/pages/profile_page.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/user_profile_image.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is FetchUserDataLoadedState) {
          return ListTile(
            leading: UserProfileImage(
              width: context.horzSize(45),
              height: context.horzSize(45),
              image: state.userData.profilePicture,
            ),
            title: Text(
              "${state.userData.firstName} ${state.userData.lastName}",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: AppColors.white),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              state.userData.userEmail,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: AppColors.white),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () {
                context.pushPage(ProfilePage(userData: state.userData));
              },
              icon: const Icon(
                Iconsax.edit,
                color: AppColors.white,
              ),
            ),
          );
        }

        return const ShimmerListTile();
      },
    );
  }
}
