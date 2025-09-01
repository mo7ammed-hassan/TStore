import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/add_new_address_form.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';

class AddNewAddressPage extends StatelessWidget {
  const AddNewAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: 'Add new Address',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
          child: const AddNewAddressForm(),
        ),
      ),
    );
  }
}
