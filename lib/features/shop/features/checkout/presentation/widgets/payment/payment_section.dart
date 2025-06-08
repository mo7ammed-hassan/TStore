import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/payment/show_payment_method_bottom_sheet.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        TSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () async {
            await showPaymentMethodBottomSheet(context, cubit);
          },
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        BlocBuilder<CheckoutCubit, CheckoutState>(
          buildWhen: (previous, current) {
            return (current is ChangePaymentMethodState);
          },
          builder: (context, state) {
            return Row(
              children: [
                TRoundedImage(
                  width: 55,
                  height: 30,
                  backgroundColor: isDark ? AppColors.light : AppColors.white,
                  imageUrl: cubit.selectedPaymentMethod!.image,
                  padding: const EdgeInsets.all(2),
                  borderRadius: 5,
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Text(
                  cubit.selectedPaymentMethod!.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
