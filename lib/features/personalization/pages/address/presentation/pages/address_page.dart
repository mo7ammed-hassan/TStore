import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_state.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/add_address_button.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/build_addresses_list_view.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddressCubit>()..fetchAllAddresses(),
      child: Scaffold(
        floatingActionButton: const AddAddressButton(),
        appBar: _buildAppBar(context),
        body: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            return ResponsivePadding.all(
              TSizes.spaceBtwItems,
              child: BuildAddressesListView(),
            );
          },
        ),
      ),
    );
  }

  TAppBar _buildAppBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: ResponsiveText(
        'Address',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
