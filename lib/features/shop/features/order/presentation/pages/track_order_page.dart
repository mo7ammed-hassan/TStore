import 'package:flutter/material.dart';
import 'package:t_store/common/common.dart';
import 'package:t_store/core/utils/utils.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/order_details_row.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/expandale_track_order_section.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key, required this.orderData});
  final OrderEntity orderData;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: 'Track Order',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.responsiveInsets.symmetric(
            horizontal: TSizes.spaceBtwItems,
            vertical: TSizes.defaultSpace / 2,
          ),
          child: Column(
            children: [
              TRoundedContainer(
                padding: context.responsiveInsets
                    .symmetric(vertical: TSizes.spaceBtwItems * 1.2),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.transparent
                        : const Color.fromARGB(255, 189, 188, 188),
                    blurRadius: 7,
                  )
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- Order ID
                    Padding(
                      padding: context.responsiveInsets
                          .symmetric(horizontal: TSizes.spaceBtwItems),
                      child: OrderDetailsRow(
                        label: 'Order#:',
                        value: orderData.orderId.substring(0, 10),
                      ),
                    ),
                    ResponsiveGap.vertical(10),
                    const Divider(),

                    // -- Order details(name + total + address)
                    Padding(
                      padding: context.responsiveInsets.symmetric(
                        horizontal: TSizes.spaceBtwItems,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // name + total
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OrderDetailsRow(
                                      label: 'Name:',
                                      value:
                                          '${orderData.shippingAddress?.name}',
                                    ),
                                    ResponsiveGap.vertical(5.0),
                                    OrderDetailsRow(
                                      label: 'Total:',
                                      value:
                                          '${orderData.checkoutModel.total}\$',
                                    ),
                                  ],
                                ),
                              ),
                              ResponsiveGap.horizontal(8.0),

                              // items
                              Flexible(
                                child: Wrap(
                                  spacing: 2,
                                  alignment: WrapAlignment.end,
                                  children: List.generate(
                                    orderData.checkoutModel.items.length,
                                    (index) => TRoundedImage(
                                      borderRadius: 8,
                                      width: context.horzSize(37),
                                      height: context.horzSize(37),
                                      imageUrl: orderData.checkoutModel
                                          .items[index].product.imageUrl,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ResponsiveGap.vertical(TSizes.spaceBtwSections - 4),

                          // address
                          OrderDetailsRow(
                            label: 'Address:',
                            maxLines: 3,
                            value: '${orderData.shippingAddress?.fullAddress}',
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    ResponsiveGap.vertical(TSizes.spaceBtwItems),

                    // -- track order section
                    const ExpandableTrackOrderSection(),
                  ],
                ),
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
