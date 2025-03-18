import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/features/shop/features/order/data/models/order_model.dart';
import 'package:t_store/features/shop/features/order/presentation/cubits/order_cubit.dart';
import 'package:t_store/features/shop/features/order/presentation/cubits/order_state.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/order_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadingState) {
          return _buildLoadingWidget();
        }

        if (state is OrderSuccessState) {
          if (state.orders.isEmpty) {
            return const Center(child: Text('No orders found!'));
          }
          return _buildOrderList(orders: state.orders);
        }

        if (state is OrderFailureState) {
          return const Center(
            child: Text('There was an error!'),
          );
        }

        return const Center(child: Text('Something went wrong!'));
      },
    );
  }

  ListView _buildOrderList({required List<OrderModel> orders}) {
    return ListView.separated(
      itemBuilder: (context, index) => OrderCard(
        order: orders[index],
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemCount: orders.length,
    );
  }

  Widget _buildLoadingWidget() {
    return ListView.separated(
      itemBuilder: (context, index) => Skeletonizer(
          child: OrderCard(
        order: OrderModel.empty(),
      )),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemCount: 6,
    );
  }
}
