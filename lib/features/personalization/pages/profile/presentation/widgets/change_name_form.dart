import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:t_store/utils/validators/validation.dart';

class ChangeNameForm extends StatelessWidget {
  const ChangeNameForm({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return Form(
      key: userCubit.fromKey,
      child: Column(
        children: [
          _buildNameField(
            context,
            controller: userCubit.firstNameController,
            label: TTexts.firstName,
            validator: (value) =>
                TValidator.validateEmptyText('First Name', value),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),
          _buildNameField(
            context,
            controller: userCubit.lastNameController,
            label: TTexts.lastName,
            validator: (value) =>
                TValidator.validateEmptyText('Last Name', value),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          _buildSaveButton(context, userCubit),
        ],
      ),
    );
  }

  Widget _buildNameField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Iconsax.user),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, UserCubit userCubit) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateUserDataLoadingState) {
            TFullScreenLoader.openLoadingDialog(
              'Processing your information...',
              TImages.docerAnimation,
            );
          } else if (state is UpdateUserSuccessState) {
            TFullScreenLoader.stopLoading();
            Navigator.of(context).pop(); // Replaces context.removePage
            Loaders.successSnackBar(
              title: 'Success',
              message: state.message,
            );
          } else if (state is UpdateUserFailureState) {
            TFullScreenLoader.stopLoading();
            Loaders.errorSnackBar(
              title: 'Error',
              message: state.errorMessage,
            );
          }
        },
        child: ElevatedButton(
          onPressed: () => userCubit.updateUserFiled(),
          child: const Text('Save'),
        ),
      ),
    );
  }
}
