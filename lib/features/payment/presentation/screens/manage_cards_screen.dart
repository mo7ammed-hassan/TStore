import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/common.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/payment/payment.dart';

class ManageCardsScreen extends StatelessWidget {
  const ManageCardsScreen({super.key, this.nestedNavigator = true});
  final bool nestedNavigator;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final order = ModalRoute.of(context)?.settings.arguments as OrderEntity?;
    final user = context.read<UserCubit>().state.user;

    return BlocProvider(
      create: (context) => getIt<PaymentMethodsCubit>()
        ..loadPaymentMethods(user?.stripeCustomerId),
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : AppColors.light,
        appBar: TAppBar(
          title: 'Bank Accounts',
          showBackArrow: true,
          nestedNavigator: nestedNavigator,
        ),
        body: Padding(
          padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
          child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
            builder: (context, state) {
              if (state is PaymentMethodsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state is PaymentMethodsLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.methods.length,
                        itemBuilder: (context, index) => CardItemWidget(
                          paymentMethod: state.methods[index],
                        ),
                        separatorBuilder: (context, index) =>
                            ResponsiveGap.vertical(16),
                      ),
                    ),
                    SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => nestedNavigator
                              ? Navigator.pushNamed(
                                  context,
                                  PaymentRoutes.addPaymentMethodScreen,
                                  arguments: order,
                                )
                              : () {},
                          child: const ResponsiveText('Add Bank Card'),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is PaymentMethodsError) {
                return ResponsiveText(
                  state.message,
                  maxLines: 10,
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
