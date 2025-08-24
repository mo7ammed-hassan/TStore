import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/common/widgets/login_signup/form_divider.dart';
import 'package:t_store/common/widgets/login_signup/social_buttons.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signin/signin_cubit.dart';
import 'package:t_store/features/authentication/presentation/widgets/login/login_form.dart';
import 'package:t_store/features/authentication/presentation/widgets/login/login_header.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: TSpacingStyles.paddingWithAppBarHeight(context),
        child: Column(
          children: [
            // Logo, Title & sub-title
            const TLoginHeader(),
            // Form
            BlocProvider(
              create: (context) => SignInCubit()..getStorageEmailAndPassword(),
              child: const TLoginForm(),
            ),
            // Divider
            const TFormDivider(dividerText: TTexts.orSignInWith),
            ResponsiveGap.vertical(TSizes.spaceBtwSections),
            // Footer
            const TSocialButtons(),
          ],
        ),
      ),
    );
  }
}
