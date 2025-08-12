import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/single_address_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({super.key, required this.addresses});
  final List<AddressEntity> addresses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        print('Addrees ID is ${address.id}');
        return SingleAddressCard(
          address: address,
          onTap: () => context.read<AddressCubit>().selecteAddress(address),
          onLongPress: () => _showDeleteBottomSheet(
            context: context,
            addressCubit: context.read<AddressCubit>(),
            addressId: address.id,
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: TSizes.spaceBtwItems,
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to delete this address?🤔',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      addressCubit.deleteAddress(addressId: addressId);
                    },
                    child: const Text(
                      'Delete ❌',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
