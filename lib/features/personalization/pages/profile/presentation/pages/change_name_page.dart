import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/change_name_body.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ChangeNamePage extends StatelessWidget {
  const ChangeNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: 'Change Name',
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.spaceBtwItems),
        child: ChangeNameBody(),
      ),
    );
  }
}
