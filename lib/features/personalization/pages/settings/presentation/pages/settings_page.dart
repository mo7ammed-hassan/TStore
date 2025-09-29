import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/core/utils/loaders/loading_dialog.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_method_cubit.dart';
import 'package:t_store/features/payment/presentation/screens/manage_cards_screen.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/widgets/settings_menu_tile.dart';
import 'package:t_store/common/widgets/appbar/t_appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_conatiner.dart';
import 'package:t_store/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';
import 'package:t_store/features/personalization/pages/address/presentation/pages/address_page.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/pages/upload_data_page.dart';
import 'package:t_store/features/shop/features/cart/presentation/pages/cart_page.dart';
import 'package:t_store/features/shop/features/order/presentation/pages/order_page.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --Header
            TPrimaryHeaderConatiner(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TAppBar(
                    title: 'Account',
                    titleColor: AppColors.white,
                    fontSize: 20,
                  ),
                  ResponsiveGap.vertical(TSizes.spaceBtwSections - 10),
                  const Flexible(fit: FlexFit.loose, child: UserProfileTile()),
                  ResponsiveGap.vertical(TSizes.spaceBtwSections),
                ],
              ),
            ),

            // --Body
            Padding(
              padding: context.responsiveInsets.all(TSizes.defaultSpace - 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  ResponsiveGap.vertical(
                    TSizes.spaceBtwItems / 2,
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set your default address',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressPage(),
                        ),
                      );
                    },
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products from cart',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'Mange your orders',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderPage(),
                        ),
                      );
                    },
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: 'Withdraw money to bank account',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => getIt<PaymentMethodCubit>()
                            ..loadPaymentMethods(user?.stripeCustomerId),
                          child: const ManageCardsScreen(),
                        ),
                      ),
                    ),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Copuns',
                    subtitle: 'your copuns codes',
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notification',
                    subtitle: 'Manage your notifications',
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connectivity',
                    onTap: () {},
                  ),
                  ResponsiveGap.vertical(
                    TSizes.spaceBtwSections - 8,
                  ),
                  const TSectionHeading(
                    title: 'General Settings',
                    showActionButton: false,
                  ),
                  ResponsiveGap.vertical(
                    TSizes.spaceBtwItems / 2,
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subtitle: 'Upload your data to server',
                    onTap: () {
                      context.pushPage(const UploadDataPage());
                    },
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set Recommendations based on your location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search results will be filtered by safe mode',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subtitle: 'The image quality will be high',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  ResponsiveGap.vertical(TSizes.spaceBtwSections),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: BlocListener<UserCubit, UserState>(
                      listener: (context, state) {
                        if (state.action == UserAction.logout &&
                            state.status == UserStatus.loading) {
                          LoadingDialog.show(context, message: 'Logout...');
                        } else if (state.action == UserAction.logout &&
                            state.status == UserStatus.success) {
                          LoadingDialog.hide(context);
                          context.pushAndClearAll(const LoginPage());
                        } else if (state.action == UserAction.logout &&
                            state.status == UserStatus.failure) {
                          LoadingDialog.hide(context);
                          Loaders.errorSnackBar(title: 'logout Failure');
                        }
                      },
                      child: OutlinedButton(
                        onPressed: () => context.read<UserCubit>().logout(),
                        child: const ResponsiveText('Logout'),
                      ),
                    ),
                  ),
                  ResponsiveGap.vertical(TSizes.spaceBtwItems * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
