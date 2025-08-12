import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/build_addresses_list_view.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.watch<AddressCubit>();
    final selectedAddress = addressCubit.selectedAddress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shiping Address',
          showActionButton: true,
          buttonTitle: 'Change',
          onPressed: () => _showAddressBottomSheet(context),
        ),
        Text(
          selectedAddress.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              selectedAddress.phoneNumber,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(
              Icons.location_history,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              '${selectedAddress.state}, ${selectedAddress.city}, ${selectedAddress.postalCode}, ${selectedAddress.country}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: addressCubit,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: BuildAddressesListView(showAddBbuton: true),
          ),
        );
      },
    );
  }
}
