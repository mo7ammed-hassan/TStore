import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_cubit.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_states.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/empty_orders_list.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/order_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderStates>(
      builder: (context, state) {
        switch (state.status) {
          case OrderStateStatus.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );

          case OrderStateStatus.success:
            if (state.orders!.isEmpty) {
              return const EmptyOrdersList();
            }
            if (state.orders != null) {}
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => OrderCard(
                order: state.orders![index],
              ),
              separatorBuilder: (context, index) =>
                  ResponsiveGap.vertical(TSizes.spaceBtwItems),
              itemCount: state.orders!.length,
            );
          case OrderStateStatus.failure:
            return Center(
              child: ResponsiveText(
                textAlign: TextAlign.center,
                maxLines: 5,
                state.errorMessage ??
                    'There was an error, please try again later',
              ),
            );

          case OrderStateStatus.initial:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
