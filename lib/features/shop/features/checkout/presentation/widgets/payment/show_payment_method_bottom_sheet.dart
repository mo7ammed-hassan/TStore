import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/checkout/data/models/payment_method_model.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/payment/payment_title.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

Future<dynamic> showPaymentMethodBottomSheet(
    BuildContext context, CheckoutCubit cubit) async {
  return showModalBottomSheet<dynamic>(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(
                  title: 'Select Payment Method', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwSections),
              PaymentTile(
                  cubit: cubit,
                  paymentMethod: const PaymentMethodModel(
                      name: 'Paypal', image: TImages.paypal)),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              PaymentTile(
                cubit: cubit,
                paymentMethod:
                    const PaymentMethodModel(name: 'Visa', image: TImages.visa),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              PaymentTile(
                cubit: cubit,
                paymentMethod: const PaymentMethodModel(
                    name: 'Paytm', image: TImages.paytm),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              PaymentTile(
                cubit: cubit,
                paymentMethod: const PaymentMethodModel(
                    name: 'Google Pay', image: TImages.googlePay),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              PaymentTile(
                cubit: cubit,
                paymentMethod: const PaymentMethodModel(
                    name: 'Apple Pay', image: TImages.applePay),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              PaymentTile(
                cubit: cubit,
                paymentMethod: const PaymentMethodModel(
                    name: 'Master Card', image: TImages.masterCard),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              PaymentTile(
                cubit: cubit,
                paymentMethod: const PaymentMethodModel(
                    name: 'Credit Card', image: TImages.creditCard),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
            ],
          ),
        ),
      );
    },
  );
}
