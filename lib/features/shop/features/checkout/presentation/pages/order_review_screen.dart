import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/checkout_button.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/chekout_order_detial.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/coupon_field.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class OrderReviewScreen extends StatelessWidget {
  final List<CartItemEntity> items;
  const OrderReviewScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit()..loadCheckout(items),
      child: Scaffold(
        bottomNavigationBar: const CheckoutButton(),
        appBar: TAppBar(
          showBackArrow: true,
          title: ResponsiveText(
            'Order Review',
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
          ),
        ),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary,
              ));
            } else if (state is CheckoutLoaded) {
              return Padding(
                padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
                child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: state.items.length,
                      itemBuilder: (_, index) => CartItemCard(
                        key: ValueKey(state.items[index].id),
                        showAddRemoveButtons: false,
                        cartItem: state.items[index],
                      ),
                      separatorBuilder: (_, __) =>
                          ResponsiveGap.vertical(TSizes.spaceBtwSections),
                    ),
                    SliverToBoxAdapter(
                      child: ResponsiveGap.vertical(TSizes.spaceBtwSections),
                    ),
                    SliverToBoxAdapter(child: const CouponFiled()),
                    SliverToBoxAdapter(
                      child: ResponsiveGap.vertical(TSizes.spaceBtwSections),
                    ),
                    SliverToBoxAdapter(
                      child: ChekoutOrderDetial(
                        orderSummary: state.orderSummary,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CheckoutError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
