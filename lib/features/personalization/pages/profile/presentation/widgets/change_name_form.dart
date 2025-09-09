import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/popups/full_screen_loader.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/common/validators/validation.dart';

class ChangeNameForm extends StatefulWidget {
  const ChangeNameForm({super.key});

  @override
  State<ChangeNameForm> createState() => _ChangeNameFormState();
}

class _ChangeNameFormState extends State<ChangeNameForm> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late final UserCubit userCuit;

  @override
  void initState() {
    super.initState();
    userCuit = context.read<UserCubit>();
    firstNameController =
        TextEditingController(text: userCuit.state.user?.firstName);
    lastNameController =
        TextEditingController(text: userCuit.state.user?.lastName);
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return Form(
      key: userCubit.fromKey,
      child: Column(
        children: [
          _buildNameField(
            context,
            controller: firstNameController,
            label: TTexts.firstName,
            validator: (value) =>
                TValidator.validateEmptyText('First Name', value),
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwInputFields),
          _buildNameField(
            context,
            controller: lastNameController,
            label: TTexts.lastName,
            validator: (value) =>
                TValidator.validateEmptyText('Last Name', value),
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwSections),
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
          if (state.action == UserAction.update &&
              state.status == UserStatus.loading) {
            TFullScreenLoader.openLoadingDialog(
              'Processing your information...',
              TImages.docerAnimation,
            );
          } else if (state.action == UserAction.update &&
              state.status == UserStatus.success) {
            TFullScreenLoader.stopLoading();
            Navigator.of(context).pop();
            Loaders.successSnackBar(
              title: 'Success',
              message: state.message ?? '',
            );
          } else if (state.action == UserAction.update &&
              state.status == UserStatus.failure) {
            TFullScreenLoader.stopLoading();
            Loaders.errorSnackBar(
              title: 'Error',
              message: state.message ?? '',
            );
          }
        },
        child: ElevatedButton(
          onPressed: () => userCubit.updateUserFiled({
            'firstName': firstNameController.text.trim(),
            'lastName': lastNameController.text.trim(),
          }),
          child: const ResponsiveText('Save'),
        ),
      ),
    );
  }
}
