import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/t_appbar.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/change_name_body.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class ChangeNamePage extends StatelessWidget {
  const ChangeNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: 'Change Name',
      ),
      body: Padding(
        padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
        child: const ChangeNameBody(),
      ),
    );
  }
}
