import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';
import 'package:t_store/features/personalization/pages/address/presentation/pages/add_new_address_page.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/single_address_card.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';

Future<dynamic> showAddressBottomSheet(
    BuildContext context, AddressCubit cubit) async {
  return showModalBottomSheet<dynamic>(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: cubit..fetchAllAddresses(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(
                    title: 'Select Address', showActionButton: false),
                const SizedBox(height: AppSizes.spaceBtwSections),
                BlocBuilder<AddressCubit, AddressState>(
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
                          if (state is SelectedAddressLoadingState)
                            _loadingWidget(),
                        ],
                      );
                    }

                    if (state is FetchAddressesFailureState) {
                      return _errorMessage();
                    }

                    return const SizedBox();
                  },
                ),
                const SizedBox(height: AppSizes.defaultSpace * 2),
                SizedBox(
                  width: double.infinity,
                  child: Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        context.pushPage(
                          AddNewAddressPage(
                            addressCubit: cubit,
                          ),
                        );
                      },
                      child: const Text('Add New Address'),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
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
    shrinkWrap: true,
    itemCount: addresses.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final address = addresses[index];
      return SingleAddressCard(
        address: address,
        onTap: () async {
          await context.read<AddressCubit>().selecteAddress(address).then(
            (value) {
              if (context.mounted) {
                context.popPage(context);
              }
            },
          );
        },
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
