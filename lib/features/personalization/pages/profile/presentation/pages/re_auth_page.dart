import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/re_auth_user_cubit.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/re_auth_form.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class ReAuthPage extends StatelessWidget {
  const ReAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReAuthUserCubit(),
      child: Scaffold(
        appBar: const TAppBar(title: 'Re-Authenticate', showBackArrow: true),
        body: Padding(
          padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
          child: const ReAuthForm(),
        ),
      ),
    );
  }
}
