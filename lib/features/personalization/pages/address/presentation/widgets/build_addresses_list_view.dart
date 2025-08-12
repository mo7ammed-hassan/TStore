import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/add_address_button.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/address_list_view.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/loaders.dart';

class BuildAddressesListView extends StatelessWidget {
  const BuildAddressesListView({super.key, this.showAddBbuton = false});
  final bool showAddBbuton;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
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
            return showAddBbuton
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      _emptyAddressesMessage(),
                      Spacer(flex: 2),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: const AddAddressButton(),
                      ),
                      Spacer(),
                    ],
                  )
                : _emptyAddressesMessage();
          }
          return Stack(
            children: [
              AddressListView(addresses: state.addresses),
              //if (state is SelectedAddressLoadingState) _loadingWidget(),
            ],
          );
        }

        if (state is FetchAddressesFailureState) {
          return _errorMessage();
        }

        return const SizedBox.shrink();
      },
      listener: (context, state) {
        if (state is SelectedAddressLoadingState) {
          Loaders.showLoading();
        }

        if (state is SelectedAddressSuccessState) {
          context.popPage(context);
        }
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
        style: TextStyle(fontSize: TSizes.md),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _errorMessage() {
    return const Center(
      child: Text(
        'There was an error, Please try again later 🫤',
        style: TextStyle(fontSize: TSizes.md),
        textAlign: TextAlign.center,
      ),
    );
  }
}
