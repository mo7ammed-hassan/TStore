import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/common.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/payment.dart';

class ManageCardsScreen extends StatelessWidget {
  const ManageCardsScreen({super.key, this.nestedNavigator = true});
  final bool nestedNavigator;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final order = ModalRoute.of(context)?.settings.arguments as OrderEntity?;

    return BlocListener<PaymentMethodCubit, PaymentMethodState>(
       listenWhen: (previous, current) =>
          current.action == PaymentMethodAction.updateDefaultMethod,
      listener: (context, state) {
        if (state.action == PaymentMethodAction.updateDefaultMethod &&
            state.status == PaymentMethodStateStatus.loading) {
          LoadingDialog.show(context);
        } else if (state.action == PaymentMethodAction.updateDefaultMethod &&
            state.status == PaymentMethodStateStatus.success) {
          LoadingDialog.hide(context);
        } else if (state.action == PaymentMethodAction.updateDefaultMethod &&
            state.status == PaymentMethodStateStatus.failure) {
          LoadingDialog.hide(context);
        }
      },
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : AppColors.light,
        appBar: TAppBar(
          title: 'Bank Accounts',
          showBackArrow: true,
          nestedNavigator: nestedNavigator,
        ),
        body: Padding(
          padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
          child: BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
            builder: (context, state) {
              if (state.action == PaymentMethodAction.fetch &&
                  state.status == PaymentMethodStateStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state.action == PaymentMethodAction.fetch &&
                      state.status == PaymentMethodStateStatus.success ||
                  state.action == PaymentMethodAction.updateDefaultMethod) {
                if (state.methods.isEmpty) {
                  return EmptyWidget(
                    nestedNavigator: nestedNavigator,
                    order: order,
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.methods.length,
                        itemBuilder: (context, index) => CardItemWidget(
                          key: ValueKey(state.methods[index].id),
                          paymentMethod: state.methods[index],
                        ),
                        separatorBuilder: (context, index) =>
                            ResponsiveGap.vertical(16),
                      ),
                    ),
                    SafeArea(
                      top: false,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => nestedNavigator
                              ? Navigator.pushNamed(
                                  context,
                                  PaymentRoutes.addPaymentMethodScreen,
                                  arguments: order,
                                )
                              : context.pushPage(
                                  MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) =>
                                            getIt<PaymentCubit>(),
                                      ),
                                      BlocProvider.value(
                                        value:
                                            context.read<PaymentMethodCubit>(),
                                      ),
                                    ],
                                    child: const AddPaymentMethodScreen(),
                                  ),
                                ),
                          child: const ResponsiveText('Add Bank Card'),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state.action == PaymentMethodAction.fetch &&
                  state.status == PaymentMethodStateStatus.failure) {
                return Center(
                  child: ResponsiveText(
                    state.message ?? 'Something went wrong',
                    maxLines: 10,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.nestedNavigator,
    required this.order,
  });

  final bool nestedNavigator;
  final OrderEntity? order;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ResponsiveText(
            'No bank cards added yet.',
          ),
          ResponsiveGap.vertical(20),
          SizedBox(
            width: context.horzSize(150),
            child: ElevatedButton(
              onPressed: () => nestedNavigator
                  ? Navigator.pushNamed(
                      context,
                      PaymentRoutes.addPaymentMethodScreen,
                      arguments: order,
                    )
                  : context.pushPage(
                      MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => getIt<PaymentCubit>(),
                          ),
                          BlocProvider.value(
                            value: context.read<PaymentMethodCubit>(),
                          ),
                        ],
                        child: const AddPaymentMethodScreen(),
                      ),
                    ),
              child: const ResponsiveText('Add Bank Card'),
            ),
          ),
        ],
      ),
    );
  }
}
