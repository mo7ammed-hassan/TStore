import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/single_address_card.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BuildAddressesListView extends StatelessWidget {
  const BuildAddressesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      buildWhen: (previous, current) =>
          current is FetchAddressesSuccessState ||
          current is FetchAddressesFailureState ||
          current is FetchAddressesLoadingState,
      builder: (context, state) {
        if (state is FetchAddressesLoadingState) {
          return _loadingWidget();
        }

        if (state is FetchAddressesSuccessState) {
          if (state.addresses.isEmpty) {
            return _emptyAddressesMessage();
          }
          return Stack(
            children: [
              _buildAddressesList(state.addresses, context),
              if (state is SelectedAddressLoadingState) _loadingWidget(),
            ],
          );
        }

        if (state is FetchAddressesFailureState) {
          return _errorMessage();
        }

        return const SizedBox();
      },
    );
  }

  // Loading Widget
  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget _emptyAddressesMessage() {
    return const Center(
      child: Text(
        'You don\'t have any addresses yet. Add one now! 🤓',
        style: TextStyle(fontSize: AppSizes.md),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAddressesList(
      List<AddressEntity> addresses, BuildContext context) {
    return ListView.separated(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
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
        height: AppSizes.spaceBtwItems,
      ),
    );
  }

  Widget _errorMessage() {
    return const Center(
      child: Text(
        'There was an error, Please try again later 🫤',
        style: TextStyle(fontSize: AppSizes.md),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Function to show the Bottom Sheet for deletion
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
