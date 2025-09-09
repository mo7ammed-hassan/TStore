import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_state.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/address_details.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class SingleAddressCard extends StatelessWidget {
  const SingleAddressCard({
    super.key,
    required this.address,
    required this.onTap,
    this.onLongPress,
    this.fontSize = 13.5,
  });
  final AddressEntity address;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return BlocBuilder<AddressCubit, AddressState>(
      buildWhen: (previous, current) {
        if (current.selectedAddress != null) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        var selectAddress = context.read<AddressCubit>().state.selectedAddress;
        var isSelectedAddress = selectAddress?.id == address.id;

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          onLongPress: onLongPress,
          child: Container(
            width: double.infinity,
            padding: context.responsiveInsets.all(TSizes.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              color: isSelectedAddress
                  ? isDark
                      ? const Color.fromARGB(255, 43, 56, 131)
                      : AppColors.lightContainer
                  : Colors.transparent,
              border: isDark
                  ? null
                  : Border.all(
                      color: isSelectedAddress
                          ? Colors.transparent
                          : AppColors.borderPrimary,
                      width: 0.3,
                    ),
              boxShadow: [
                if (!isSelectedAddress)
                  BoxShadow(
                    color: isDark
                        ? Colors.grey.withValues(alpha: 0.1)
                        : AppColors.light.withValues(alpha: 0.1),
                    blurRadius: 0,
                    offset: const Offset(0, 0),
                  )
              ],
            ),
            // showBorder: true,
            // borderColor: isSelectedAddress ? Colors.transparent : null,
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    isSelectedAddress ? Iconsax.tick_circle5 : null,
                    color: isSelectedAddress
                        ? isDark
                            ? AppColors.light
                            : AppColors.primary
                        : null,
                  ),
                ),
                AddressDetails(
                  address: address,
                  fontSize: fontSize,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
