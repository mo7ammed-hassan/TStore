import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_profile_menu.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/pages/change_name_page.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/profile_menu.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';

class ProfileInformationSection extends StatelessWidget {
  const ProfileInformationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.status == UserStatus.loading) {
          return const Column(
            children: [
              ShimmerProfileMenu(),
              ShimmerProfileMenu(),
            ],
          );
        }

        if (state.status == UserStatus.success) {
          switch (state.action) {
            case UserAction.fetch:
              return _userinfoWidget(state, context);
            case UserAction.update:
              return _userinfoWidget(state, context);
            case UserAction.logout:
              return _userinfoWidget(state, context);
          }
        }

        return const SizedBox.shrink();
      },
    );
  }

  Column _userinfoWidget(UserState state, BuildContext context) {
    return Column(
      children: [
        ProfileMenu(
          title: 'Name',
          value: '${state.user?.firstName} ${state.user?.lastName}',
          onPressed: () => context.pushPage(const ChangeNamePage()),
        ),
        ProfileMenu(
          title: 'Username',
          value: state.user?.username ?? '',
          onPressed: () {},
        ),
      ],
    );
  }
}
