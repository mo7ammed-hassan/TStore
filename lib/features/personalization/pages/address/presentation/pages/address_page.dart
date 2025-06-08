import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';
import 'package:t_store/features/personalization/pages/address/presentation/pages/add_new_address_page.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/build_addresses_list_view.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..fetchAllAddresses(),
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        appBar: _buildAppBar(context),
        body: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            return Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.all(AppSizes.spaceBtwItems),
                  child: BuildAddressesListView(),
                ),
                if (state is SelectedAddressLoadingState ||
                    state is DeleteAddressLoadingState)
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      //👈 Wrap with Builder
      builder: (context) {
        final addressCubit = context.read<AddressCubit>();
        return FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                // 👈 Pass cubit or use BlocProvider.value
                builder: (context) => AddNewAddressPage(
                  addressCubit: addressCubit,
                ),
              ),
            );
          },
          child: const Icon(
            Iconsax.add,
            color: AppColors.white,
          ),
        );
      },
    );
  }

  TAppBar _buildAppBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: Text(
        'Address',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
