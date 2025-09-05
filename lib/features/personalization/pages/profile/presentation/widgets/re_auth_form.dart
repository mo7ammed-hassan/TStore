import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:t_store/common/widgets/text_filed/password_field.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/re_auth_user_cubit.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/re_auth_user_state.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/utils/validators/validation.dart';

class ReAuthForm extends StatelessWidget {
  const ReAuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReAuthUserCubit>();
    return BlocListener<ReAuthUserCubit, ReAuthUserState>(
      listener: (context, state) {
        if (state is ReAuthLoadingState) {
          TFullScreenLoader.openLoadingDialog(
            'Processing...',
            TImages.docerAnimation,
          );
        } else if (state is ReAuthSuccessState) {
          TFullScreenLoader.stopLoading();
          context.pushAndClearAll(const LoginPage());
        } else {
          TFullScreenLoader.stopLoading();
          TFullScreenLoader.openLoadingDialog(
            'Email or Password is incorrect, Please, try again.',
            TImages.docerAnimation,
          );
        }
      },
      child: Form(
        key: cubit.formKey,
        child: Column(
          children: [
            _buildEmailField(cubit),
            ResponsiveGap.vertical(TSizes.spaceBtwInputFields),
            _buildPasswordField(cubit),
            ResponsiveGap.vertical(TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => cubit.reauthenticate(),
                child: const ResponsiveText('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(ReAuthUserCubit cubit) {
    return TextFormField(
      controller: cubit.emailController,
      validator: TValidator.validateEmail,
      decoration: const InputDecoration(
        labelText: TTexts.email,
        prefixIcon: Icon(Iconsax.direct_right),
      ),
    );
  }

  Widget _buildPasswordField(ReAuthUserCubit cubit) {
    return BlocProvider(
      create: (context) => PasswordAndSelectionCubit(),
      child: PasswordField(controller: cubit.passwordController),
    );
  }
}
