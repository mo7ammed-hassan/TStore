import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/pages/add_new_address_page.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();

    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: addressCubit,
              child: const AddNewAddressPage(),
            ),
          ),
        );
      },
      child: const Icon(
        Iconsax.add,
        color: AppColors.white,
      ),
    );
  }
}
