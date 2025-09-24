import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/loaders/loading_dialog.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/features/personalization/pages/address/data/mapper/address_mapper.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_state.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/common/validators/validation.dart';

class AddNewAddressForm extends StatefulWidget {
  const AddNewAddressForm({super.key});

  @override
  State<AddNewAddressForm> createState() => _AddNewAddressFormState();
}

class _AddNewAddressFormState extends State<AddNewAddressForm> {
  late final AddressCubit addressCubit;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    addressCubit = context.read<AddressCubit>();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user),
              labelText: 'Name',
            ),
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwInputFields),
          TextFormField(
            controller: phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.mobile),
              labelText: 'Phone Number',
            ),
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: streetController,
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
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: postalCodeController,
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
          ResponsiveGap.vertical(TSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: cityController,
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
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: stateController,
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
          ResponsiveGap.vertical(TSizes.spaceBtwInputFields),
          TextFormField(
            controller: countryController,
            validator: (value) =>
                TValidator.validateEmptyText('Country', value),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.global),
              labelText: 'Country',
            ),
          ),
          const SizedBox(height: TSizes.defaultSpace),
          BlocListener<AddressCubit, AddressState>(
            listener: (context, state) {
              if (state.status == AddressStatus.loading) {
                LoadingDialog.show(context, message: 'Adding your address...');
              }

              if (state.status == AddressStatus.addedSuccess) {
                LoadingDialog.hide(context);
                Navigator.pop(context);
                Navigator.pop(context, state.selectedAddress);
                Loaders.customToast(
                  message: 'Address added successfully 🥳',
                );
              }

              if (state.status == AddressStatus.failure) {
                Navigator.pop(context);
                Loaders.errorSnackBar(
                  title: 'Error',
                  message: state.errorMessage ??
                      'There was an error adding your address',
                );
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final AddressModel address = AddressModel(
                    name: nameController.text,
                    phoneNumber: phoneController.text,
                    street: streetController.text,
                    postalCode: postalCodeController.text,
                    city: cityController.text,
                    state: stateController.text,
                    country: countryController.text,
                    createdAt: DateTime.now(),
                    selectedAddress: true,
                  );

                  await addressCubit.addAddress(address.toEntity());
                },
                child: const ResponsiveText('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
