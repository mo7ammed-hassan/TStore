import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/payment/presentation/screens/payment_flow_screen.dart';
import 'package:t_store/features/payment/presentation/routes/payment_flow_args.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_cubit.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/cancel_order_dialog.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final orderCubit = context.read<OrderCubit>();
    return GestureDetector(
      onTap: () => order.orderStatus == OrderStatus.unCompleted.name
          ? context.pushPage(
              BlocProvider.value(
                value: orderCubit,
                child: PaymentFlowScreen(
                  args: PaymentFlowArgs(
                    order: order,
                    entryPoint: PaymentEntryPoint.orderPage,
                  ),
                  entryPoint: PaymentEntryPoint.orderPage,
                ),
              ),
            )
          : null,
      child: Dismissible(
        key: ValueKey(order.orderId),
        direction: DismissDirection.startToEnd,
        confirmDismiss: order.orderStatus != OrderStatus.unCompleted.name
            ? (_) async {
                return false;
              }
            : (_) async {
                final result = await showCancelOrderDialog(
                  context,
                  orderId: order.orderId,
                );
                return result; // true => remove, false => keep
              },
        background: const TRoundedContainer(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        child: TRoundedContainer(
          key: ValueKey(order.orderId),
          padding: context.responsiveInsets.all(TSizes.md),
          showBorder: true,
          backgroundColor: isDark ? AppColors.dark : AppColors.light,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.ship,
                    size: context.horzSize(23),
                  ),
                  ResponsiveGap.horizontal(TSizes.spaceBtwItems / 2),
                  Expanded(
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // to take only required space
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveText(
                          order.orderStatus[0].toUpperCase() +
                              order.orderStatus.substring(1),
                          style: Theme.of(context).textTheme.bodyLarge!.apply(
                                color: AppColors.primary,
                                fontSizeDelta: 1, // reduce the size
                              ),
                        ),
                        ResponsiveText(
                          HelperFunctions().formatOrderDate(order.updatedAt!),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.arrow_right_34,
                      size: context.horzSize(20),
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
                        Icon(
                          Iconsax.tag,
                          size: context.horzSize(23),
                        ),
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
                                '[#${order.orderId.substring(0, 8)}]',
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
                        Icon(
                          Iconsax.calendar,
                          size: context.horzSize(23),
                        ),
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
                                //'03 Feb 2024',
                                HelperFunctions()
                                    .formatOrderDate(order.createdAt),
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
        ),
      ),
    );
  }
}
