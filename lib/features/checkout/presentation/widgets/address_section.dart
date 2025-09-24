import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_address_card.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/address_details.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/build_addresses_list_view.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class AddressSection extends StatefulWidget {
  const AddressSection({super.key, this.addressEntity});
  final AddressEntity? addressEntity;

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  late CheckoutCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CheckoutCubit>();
    if (widget.addressEntity != null) {
      cubit.chengeAdress(widget.addressEntity!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<CheckoutCubit>().state.address;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          showActionButton: true,
          buttonTitle: 'Change',
          fontSize: 14.5,
          onPressed: () =>
              _showAddressBottomSheet(context, context.read<AddressCubit>()),
        ),
        (context.watch<CheckoutCubit>().state.loadAddress == true)
            ? const ShimmerAddressCard()
            : address?.id.isNotEmpty == true
                ? AddressDetails(address: address!)
                : const ResponsiveText(
                    'Please Select Address',
                    fontSize: 13.5,
                  ),
      ],
    );
  }

  Future _showAddressBottomSheet(
      BuildContext context, AddressCubit addressCubit) async {
    final selectedAddress = await showModalBottomSheet<AddressEntity?>(
      sheetAnimationStyle: const AnimationStyle(
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 300),
      ),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: addressCubit,
          child: Padding(
            padding: context.responsiveInsets
                .symmetric(horizontal: TSizes.defaultSpace),
            child: BuildAddressesListView(
              showAddButton: true,
              onAddressSelected: (address) async {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ),
        );
      },
    );

    if (context.mounted) {
      context.read<CheckoutCubit>().chengeAdress(selectedAddress);
    }
  }
}
