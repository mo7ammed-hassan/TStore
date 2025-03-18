import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/delete_user_account_cubit.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/delete_user_account_state.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/pages/re_auth_page.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class CloseAccountButton extends StatelessWidget {
  const CloseAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeleteUserAccountCubit(),
      child: BlocListener<DeleteUserAccountCubit, DeleteUserAccountState>(
        listener: (context, state) {
          if (state is ReAuthUserState) {
            context.pushPage(const ReAuthPage());
          } else if (state is DeleteUserAccountSuccess) {
            context.removeAll(const LoginPage());
          }
        },
        child: Builder(
          builder: (context) {
            return TextButton(
              onPressed: () => _showDeleteAccountPopup(context),
              child: const Text(
                'Close Account',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteAccountPopup(BuildContext context) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(AppSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently?This action is not reservable and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide.none,
          backgroundColor: AppColors.warning,
        ),
        onPressed: () {
          context.read<DeleteUserAccountCubit>().deleteUserAccount();
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    );
  }
}
