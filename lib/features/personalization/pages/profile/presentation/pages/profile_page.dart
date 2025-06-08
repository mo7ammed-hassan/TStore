import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';

import 'package:t_store/common/widgets/texts/section_heading.dart';

import 'package:t_store/features/personalization/domain/entites/user_entity.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/close_account_button.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/personal_information_section.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/profile_header.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/profile_information_section.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity? userData;
  const ProfilePage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Profile'), showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
        child: Column(
          children: [
            const ProfileHeader(),
            const Divider(),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const TSectionHeading(
              title: 'Profile Information',
              showActionButton: false,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const ProfileInformationSection(),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: AppSizes.spaceBtwItems),

            ///Heading
            const TSectionHeading(
              title: 'Personal Information',
              showActionButton: false,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            PersonalInformationSection(user: userData!),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: AppSizes.spaceBtwItems),

            const CloseAccountButton(),
          ],
        ),
      ),
    );
  }
}
