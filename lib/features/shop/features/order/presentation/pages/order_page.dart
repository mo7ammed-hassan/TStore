import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/order/presentation/cubits/order_cubit.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/order_list_items.dart';
import 'package:t_store/utils/constants/sizes.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..fetchOrders(), 
      child: Scaffold(
        appBar: _appBar(context),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.spaceBtwItems,
            vertical: AppSizes.defaultSpace,
          ),
          child: OrderListItems(),
        ),
      ),
    );
  }

  TAppBar _appBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: Text(
        'My Orders',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}

