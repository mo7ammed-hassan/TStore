import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/widgets/upload_data_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

class RelationshipsSection extends StatelessWidget {
  const RelationshipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UploadDataCard(
          leadingIcon: Iconsax.link,
          title: 'Upload Brands & Categories Relation Data',
        ),
        ResponsiveGap.vertical(TSizes.md),
        const UploadDataCard(
          leadingIcon: Iconsax.link,
          title: 'Upload Products Categories Relational Data',
        ),
      ],
    );
  }
}
