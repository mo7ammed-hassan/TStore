import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/delete_user_account_cubit.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/delete_user_account_state.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/pages/re_auth_page.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

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
              child: const ResponsiveText(
                'Close Account',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteAccountPopup(BuildContext context) {
    final cubit = context.read<DeleteUserAccountCubit>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const ResponsiveText('Delete Account'),
          content: const ResponsiveText(
            'Are you sure you want to delete your account permanently?\n\nThis action is not reversible and all of your data will be removed permanently.',
            maxLines: 7,
            textAlign: TextAlign.center,
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
              ),
              onPressed: () => Navigator.pop(context),
              child: const ResponsiveText('Cancel', fontSize: 13),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warning,
                side: BorderSide.none,
              ),
              onPressed: () {
                cubit.deleteUserAccount();
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    context.responsiveInsets.symmetric(horizontal: TSizes.lg),
                child: const ResponsiveText('Delete', fontSize: 13),
              ),
            ),
          ],
        );
      },
    );
  }
}
