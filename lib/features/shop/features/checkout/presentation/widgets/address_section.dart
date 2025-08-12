import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/build_addresses_list_view.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.watch<AddressCubit>();
    final selectedAddress = addressCubit.selectedAddress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          showActionButton: true,
          buttonTitle: 'Change',
          onPressed: () => _showAddressBottomSheet(context),
        ),
        if (selectedAddress.id.isNotEmpty)
          AddressDetails(address: selectedAddress)
        else
          const Text('Please Select Address'),
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

class AddressDetails extends StatelessWidget {
  final AddressEntity address;

  const AddressDetails({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        AddressInfoRow(
          icon: Icons.phone,
          text: address.phoneNumber,
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        AddressInfoRow(
          icon: Icons.location_history,
          text: '${address.state}, ${address.city}, '
              '${address.postalCode}, ${address.country}',
        ),
      ],
    );
  }
}

class AddressInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const AddressInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: TSizes.spaceBtwItems),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
