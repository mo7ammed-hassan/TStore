import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class SingleAddressCard extends StatelessWidget {
  const SingleAddressCard(
      {super.key,
      required this.address,
      required this.onTap,
      this.onLongPress});
  final AddressEntity address;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return BlocBuilder<AddressCubit, AddressState>(
      buildWhen: (previous, current) {
        if (current is SelectedAddressSuccessState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        var selectAddress = context.read<AddressCubit>().selectedAddress;
        var isSelectedAddress = selectAddress.id == address.id;

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          onLongPress: onLongPress,
          child: TRoundedContainer(
            width: double.infinity,
            backgroundColor: isSelectedAddress
                ? AppColors.primary.withValues(alpha: 0.4)
                : Colors.transparent,
            padding: const EdgeInsets.all(TSizes.md),
            showBorder: true,
            borderColor: isSelectedAddress ? Colors.transparent : null,
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
                            : AppColors.dark
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: TSizes.sm / 2),
                    Text(
                      address.phoneNumber,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: TSizes.sm / 2),
                    Text(
                      '${address.street}, ${address.state}, ${address.country}, ${address.postalCode}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
