import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/build_save_address_button.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/validators/validation.dart';

class AddAddressForm extends StatelessWidget {
  const AddAddressForm({
    super.key,
    required this.addressCubit,
  });

  final AddressCubit addressCubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addressCubit.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: addressCubit.nameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user),
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),
          TextFormField(
            controller: addressCubit.phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.mobile),
              labelText: 'Phone Number',
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: addressCubit.streetController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      TValidator.validateEmptyText('Street', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: 'Street',
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: addressCubit.postalCodeController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      TValidator.validateEmptyText('Postal Code', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.code),
                    labelText: 'Postal Code',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: addressCubit.cityController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      TValidator.validateEmptyText('City', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building),
                    labelText: 'City',
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: addressCubit.stateController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      TValidator.validateEmptyText('State', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.activity),
                    labelText: 'State',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),
          TextFormField(
            controller: addressCubit.countryController,
            validator: (value) =>
                TValidator.validateEmptyText('Country', value),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.global),
              labelText: 'Country',
            ),
          ),
          const SizedBox(height: AppSizes.defaultSpace),
          BuildSaveAddressButton(addressCubit: addressCubit),
        ],
      ),
    );
  }
}
