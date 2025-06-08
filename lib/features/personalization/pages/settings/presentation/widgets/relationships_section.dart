import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/widgets/upload_data_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class RelationshipsSection extends StatelessWidget {
  const RelationshipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UploadDataCard(
          leadingIcon: Iconsax.link,
          title: 'Upload Brands & Categories Relation Data',
        ),
        SizedBox(height: AppSizes.md),
        UploadDataCard(
          leadingIcon: Iconsax.link,
          title: 'Upload Products Categories Relational Data',
        ),
      ],
    );
  }
}
