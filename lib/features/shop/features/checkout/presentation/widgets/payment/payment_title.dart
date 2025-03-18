import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/shop/features/checkout/data/models/payment_method_model.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile(
      {super.key, required this.paymentMethod, required this.cubit});
  final PaymentMethodModel paymentMethod;
  final CheckoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        cubit.changePaymentMethod(paymentMethod: paymentMethod);
        context.popPage(context);
      },
      leading: TRoundedContainer(
        padding: const EdgeInsets.all(AppSizes.sm),
        width: 60,
        height: 40,
        backgroundColor: HelperFunctions.isDarkMode(context)
            ? AppColors.light
            : AppColors.white,
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
