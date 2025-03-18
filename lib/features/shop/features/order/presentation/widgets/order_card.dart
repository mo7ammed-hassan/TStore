import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/shop/features/order/data/models/order_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: const EdgeInsets.all(AppSizes.md),
      showBorder: true,
      backgroundColor: isDark ? AppColors.dark : AppColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Iconsax.ship),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // to take only required space
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderStatusText,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: AppColors.primary,
                            fontSizeDelta: 1, // reduce the size
                          ),
                    ),
                    Text(
                      order.formattedOrderDate,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.arrow_right_34,
                  size: AppSizes.iconSm,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Iconsax.tag),
                    const SizedBox(width: AppSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            order.id,
                            style: Theme.of(context).textTheme.titleMedium,
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
                    const SizedBox(width: AppSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Date',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            order.formattedDeliveryDate,
                            style: Theme.of(context).textTheme.titleMedium,
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
