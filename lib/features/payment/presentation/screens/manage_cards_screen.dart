import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/common.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/payment.dart';
import 'package:t_store/features/payment/presentation/widgets/empty_manage_card_view.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_methods_list_view.dart';

class ManageCardsScreen extends StatelessWidget {
  const ManageCardsScreen({super.key});

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
        }
      },
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : AppColors.light,
        appBar: TAppBar(
          title: 'Bank Accounts',
          showBackArrow: true,
          nestedNavigator: order != null,
        ),
        body: Padding(
          padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
          child: BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
            buildWhen: (previous, current) =>
                current.methods != previous.methods,
            builder: (context, state) {
              switch (state.status) {
                case PaymentMethodStateStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );

                case PaymentMethodStateStatus.success:
                  if (state.methods.isEmpty) {
                    return EmptyManageCardView(order: order);
                  }
                  return PaymentMethodsListView(
                    methods: state.methods,
                    order: order,
                  );
                case PaymentMethodStateStatus.failure:
                  return Center(
                    child: ResponsiveText(
                      state.message ?? 'Something went wrong',
                      maxLines: 10,
                    ),
                  );

                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
