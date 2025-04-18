import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/address/show_address_bottom_sheet.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..fetchAllAddresses(),
      child: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(
                title: 'Shiping Address',
                buttonTitle: 'Change',
                onPressed: () async {
                  await showAddressBottomSheet(
                    context,
                    context.read<AddressCubit>(),
                  );
                },
              ),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  final address = context.read<AddressCubit>().selectedAddress;
                  context.read<CheckoutCubit>().selectedAddress =
                      address.toModel();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems / 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: AppSizes.spaceBtwItems),
                          Text(
                            address.phoneNumber,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems / 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_history,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: AppSizes.spaceBtwItems),
                          Flexible(
                            child: Text(
                              '${address.city}, ${address.street}, ${address.postalCode}, ${address.state}, ${address.country}',
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
