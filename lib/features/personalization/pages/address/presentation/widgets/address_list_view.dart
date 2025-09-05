import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/single_address_card.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({
    super.key,
    required this.addresses,
    this.fontSize = 13.5,
    this.onAddressSelected,
  });
  final List<AddressEntity> addresses;
  final double fontSize;
  final ValueChanged<AddressEntity>? onAddressSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return SingleAddressCard(
          fontSize: fontSize,
          address: address,
          onTap: () async {
            Loaders.showSimpleLoading(context);
            final newAddress =
                await context.read<AddressCubit>().updateSelectAddress(address);

            if (context.mounted) context.popPage();

            if (newAddress != null) {
              onAddressSelected?.call(newAddress);
            }
          },
          onLongPress: () => _showDeleteBottomSheet(
            context: context,
            addressCubit: context.read<AddressCubit>(),
            addressId: address.id,
          ),
        );
      },
      separatorBuilder: (context, index) => ResponsiveGap.vertical(
        TSizes.spaceBtwItems,
      ),
    );
  }

  void _showDeleteBottomSheet({
    required BuildContext context,
    required AddressCubit addressCubit,
    required String addressId,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              context.responsiveInsets.symmetric(horizontal: 16, vertical: 8),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ResponsiveText(
                  'Are you sure you want to delete this address?🤔',
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                ResponsiveGap.vertical(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const ResponsiveText(
                        'Cancel',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        addressCubit.deleteAddress(addressId);
                      },
                      child: const ResponsiveText(
                        'Delete ❌',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
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
