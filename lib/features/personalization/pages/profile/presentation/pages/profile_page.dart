import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';

import 'package:t_store/common/widgets/texts/section_heading.dart';

import 'package:t_store/features/personalization/domain/entites/user_entity.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/close_account_button.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/personal_information_section.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/profile_header.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/profile_information_section.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity? userData;
  const ProfilePage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: ResponsiveText(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
        child: Column(
          children: [
            const ProfileHeader(),
            const Divider(),
            ResponsiveGap.vertical(TSizes.spaceBtwItems),
            const TSectionHeading(
              title: 'Profile Information',
              showActionButton: false,
            ),
            ResponsiveGap.vertical(TSizes.spaceBtwItems),
            const ProfileInformationSection(),
            ResponsiveGap.vertical(TSizes.spaceBtwItems),
            const Divider(),
            ResponsiveGap.vertical(TSizes.spaceBtwItems),

            ///Heading
            const TSectionHeading(
              title: 'Personal Information',
              showActionButton: false,
            ),
            ResponsiveGap.vertical(TSizes.spaceBtwItems),
            PersonalInformationSection(user: userData!),
            ResponsiveGap.vertical(TSizes.spaceBtwItems),
            const Divider(),
            ResponsiveGap.vertical(TSizes.spaceBtwItems),

            const CloseAccountButton(),
          ],
        ),
      ),
    );
  }
}
