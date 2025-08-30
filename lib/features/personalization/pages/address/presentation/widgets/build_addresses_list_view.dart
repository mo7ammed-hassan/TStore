import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_state.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/add_address_button.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/address_list_view.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class BuildAddressesListView extends StatelessWidget {
  const BuildAddressesListView(
      {super.key, this.showAddButton = false, this.fontSize = 13.5});
  final bool showAddButton;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      buildWhen: (old, current) =>
          old.status != current.status || old.addresses != current.addresses,
      listener: (context, state) {
        if (state.status == AddressStatus.failure &&
            state.errorMessage != null) {
          Loaders.errorSnackBar(title: state.errorMessage!);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case AddressStatus.loading:
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );

          case AddressStatus.success:
          case AddressStatus.addedSuccess:
            if (state.addresses.isEmpty) {
              return showAddButton
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        _emptyAddressesMessage(),
                        const Spacer(flex: 2),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: AddAddressButton(),
                        ),
                        const Spacer(),
                      ],
                    )
                  : _emptyAddressesMessage();
            }
            return Stack(
              children: [
                AddressListView(
                  addresses: state.addresses,
                  fontSize: fontSize,
                ),
                if (showAddButton)
                  const Positioned(
                    bottom: kToolbarHeight,
                    right: 0,
                    child: AddAddressButton(),
                  ),
              ],
            );

          case AddressStatus.failure:
            return _errorMessage();

          case AddressStatus.empty:
            return _emptyAddressesMessage();

          case AddressStatus.initial:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _emptyAddressesMessage() {
    return const Center(
      child: ResponsiveText(
        'You don\'t have any addresses yet. Add one now! 🤓',
        style: TextStyle(fontSize: TSizes.md),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _errorMessage() {
    return const Center(
      child: ResponsiveText(
        'There was an error, Please try again later 🫤',
        style: TextStyle(fontSize: TSizes.md),
        textAlign: TextAlign.center,
      ),
    );
  }
}
