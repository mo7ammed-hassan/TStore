import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/popups/loaders.dart';

class BuildSaveAddressButton extends StatelessWidget {
  const BuildSaveAddressButton({super.key, required this.addressCubit});

  final AddressCubit addressCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: addressCubit,
      child: BlocListener<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddAddressSuccessState) {
            Navigator.pop(context);
            Loaders.customToast(
              message: 'Address added successfully 🥳',
            );
          }

          if (state is AddAddressFailureState) {
            Loaders.errorSnackBar(
              title: 'Error',
              message: 'There was an error adding your address',
            );
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (addressCubit.validateForm()) {
                await addressCubit.addNewAddress();
              }
            },
            child: BlocBuilder<AddressCubit, AddressState>(
              buildWhen: (previous, current) {
                return current is AddAddressLoadingState;
              },
              builder: (context, state) {
                if (state is AddAddressLoadingState) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 20,
                        minHeight: 20,
                      ),
                      child: const FittedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  );
                }
                return const Text('Save');
              },
            ),
          ),
        ),
      ),
    );
  }
}
