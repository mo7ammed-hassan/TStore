import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/presentation/widgets/address_info_row.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart'
    show ResponsiveGap;
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class AddressDetails extends StatelessWidget {
  final AddressEntity address;
  const AddressDetails({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          address.name,
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13.5),
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        AddressInfoRow(
          icon: Icons.phone,
          text: address.phoneNumber,
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        AddressInfoRow(
          icon: Iconsax.location,
          text: '${address.state}, ${address.city}, '
              '${address.postalCode}, ${address.country}',
        ),
      ],
    );
  }
}
