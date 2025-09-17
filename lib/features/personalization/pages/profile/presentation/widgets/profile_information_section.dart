import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocSelector<UserCubit, UserState, Map<String, String>>(
      selector: (state) => {
        'firstName': state.user?.firstName ?? '',
        'lastName': state.user?.lastName ?? '',
        'username': state.user?.username ?? '',
      },
      builder: (context, userData) {
        return Column(
          children: [
            ProfileMenu(
              title: 'Name',
              value: '${userData['firstName']} ${userData['lastName']}',
              onPressed: () => context.pushPage(const ChangeNamePage()),
            ),
            ProfileMenu(
              title: 'Username',
              value: userData['username'] ?? '',
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
