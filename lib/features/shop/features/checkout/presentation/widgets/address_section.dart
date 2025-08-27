import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/address_details.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/build_addresses_list_view.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.watch<AddressCubit>();
    final selectedAddress = addressCubit.state.selectedAddress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          showActionButton: true,
          buttonTitle: 'Change',
          onPressed: () => _showAddressBottomSheet(context),
        ),
        if (selectedAddress?.id.isNotEmpty == true)
          AddressDetails(address: selectedAddress!)
        else
          const ResponsiveText('Please Select Address'),
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
          child: Padding(
            padding: context.responsiveInsets
                .symmetric(horizontal: TSizes.defaultSpace),
            child: BuildAddressesListView(
              showAddButton: true,
            ),
          ),
        );
      },
    );
  }
}


