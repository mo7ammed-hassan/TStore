import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/t_appbar.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/checkout/presentation/widgets/confirm_order_button.dart';
import 'package:t_store/features/checkout/presentation/widgets/chekout_order_detial.dart';
import 'package:t_store/features/checkout/presentation/widgets/coupon_field.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class OrderReviewScreen extends StatelessWidget {
  final List<CartItemEntity>? items;
  final OrderEntity? order;
  final bool removeCartItems;
  const OrderReviewScreen({
    super.key,
    this.items,
    this.order,
    this.removeCartItems = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CheckoutCubit>()
        ..init(items ?? order?.checkoutModel.items ?? []),
      child: Scaffold(
        bottomNavigationBar: ConfirmOrderButton(
          removeCartItems: removeCartItems,
          order: order,
        ),
        appBar: const TAppBar(
          showBackArrow: true,
          title: 'Order Review',
        ),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          buildWhen: (previous, current) => current != previous,
          builder: (context, state) {
            switch (state.status) {
              case CheckoutStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );

              case CheckoutStatus.success:
                final orderSummary = state.checkoutData?.orderSummary ??
                    order?.checkoutModel.orderSummary;
                final address =
                    order?.shippingAddress ?? state.order?.shippingAddress;
                return Padding(
                  padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList.separated(
                        itemCount: state.checkoutData?.items.length ?? 0,
                        itemBuilder: (_, index) => CartItemCard(
                          key: ValueKey(state.checkoutData?.items[index].id),
                          showAddRemoveButtons: false,
                          cartItem: state.checkoutData!.items[index],
                        ),
                        separatorBuilder: (_, __) =>
                            ResponsiveGap.vertical(TSizes.spaceBtwSections),
                      ),
                      SliverToBoxAdapter(
                        child: ResponsiveGap.vertical(TSizes.spaceBtwSections),
                      ),
                      const SliverToBoxAdapter(child: CouponFiled()),
                      SliverToBoxAdapter(
                        child: ResponsiveGap.vertical(TSizes.spaceBtwSections),
                      ),
                      SliverToBoxAdapter(
                        child: ChekoutOrderDetial(
                          orderSummary: orderSummary,
                          address: address,
                        ),
                      ),
                    ],
                  ),
                );

              case CheckoutStatus.failure:
                return Center(child: ResponsiveText(state.message));

              case CheckoutStatus.initial:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
