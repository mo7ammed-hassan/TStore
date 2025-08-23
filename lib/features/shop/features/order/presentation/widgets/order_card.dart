import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: context.responsiveInsets.all(TSizes.md),
      showBorder: true,
      backgroundColor: isDark ? AppColors.dark : AppColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Iconsax.ship),
              ResponsiveGap.horizontal(TSizes.spaceBtwItems / 2),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // to take only required space
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(
                      'Proccessing',
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: AppColors.primary,
                            fontSizeDelta: 1, // reduce the size
                          ),
                    ),
                    ResponsiveText(
                      '11 Nov 2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.arrow_right_34,
                  size: context.horzSize(18),
                ),
              ),
            ],
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Iconsax.tag),
                    ResponsiveGap.horizontal(TSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // to take only required space
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveText(
                            'Order',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          ResponsiveText(
                            '[#256f2]',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(Iconsax.calendar),
                    ResponsiveGap.horizontal(TSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // to take only required space
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveText(
                            'Shipping Date',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          ResponsiveText(
                            '03 Feb 2024',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
