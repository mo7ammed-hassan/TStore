import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/payment/payment.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({super.key, required this.paymentMethod});
  final PaymentMethodEntity paymentMethod;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final StripeCardMethodEntity method =
        paymentMethod as StripeCardMethodEntity;
    final customerId = context.read<UserCubit>().state.user?.stripeCustomerId;

    return TRoundedContainer(
      padding: context.responsiveInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Card Header (Name + Number + Type) ---
          _CardHeader(isDark: isDark, paymentMethod: method),

          ResponsiveGap.vertical(16),

          /// --- Expire Date ---
          ResponsiveTextSpan(
            text: 'Expire Date:',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.4,
                ),
            children: [
              ResponsiveTextSpan(
                text:
                    ' ${method.card?.expMonth}/${method.card?.expYear.toString().substring(2)}',
                fontSize: 12.4,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),

          ResponsiveGap.vertical(20),

          /// --- Primary Card Indicator ---
          _PrimaryCardIndicator(method, customerId),

          ResponsiveGap.vertical(22),

          /// --- Actions (Delete / Update) ---
          _CardActions(customerId!, method.id),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.isDark, required this.paymentMethod});
  final bool isDark;
  final PaymentMethodEntity<StripeCardMethodEntity> paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Card Holder Name & Number
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText(
                '${paymentMethod.method.billingDetails?.name}',
              ),
              ResponsiveGap.vertical(6),
              ResponsiveText(
                'xxxxxx${paymentMethod.method.card?.last4}',
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ],
          ),
        ),

        /// Card Type (e.g. VISA, MasterCard)
        Container(
          width: context.horzSize(110),
          height: context.horzSize(45),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkerGrey : AppColors.light,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: context.responsiveInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
          child: Center(
            child: FittedBox(
              child: ResponsiveText(
                '${paymentMethod.method.card?.brand}',
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryCardIndicator extends StatelessWidget {
  const _PrimaryCardIndicator(this.method, this.customerId);
  final PaymentMethodEntity method;
  final String? customerId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
      buildWhen: (previous, current) =>
          current.action == PaymentMethodAction.updateDefaultMethod,
      builder: (context, state) {
        bool defaultMethod = state.defaultMethod?.id == method.id;
        return Row(
          children: [
            GestureDetector(
              onTap: () => context
                  .read<PaymentMethodCubit>()
                  .updateDefaultMethod(method, customerId),
              child: AnimatedContainer(
                width: context.horzSize(defaultMethod ? 19 : 17.5),
                height: context.horzSize(defaultMethod ? 19 : 17.5),
                padding: context.responsiveInsets.all(4.5),
                duration: const Duration(milliseconds: 300),
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                      side: BorderSide(
                    color: defaultMethod ? Colors.transparent : Colors.grey,
                  )),
                  color: defaultMethod ? AppColors.primary : null,
                ),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    color: defaultMethod ? Colors.white : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ResponsiveText(
              'Primary Card',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 13.3),
            ),
          ],
        );
      },
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions(this.customerId, this.methodId);
  final String customerId, methodId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Delete
        Expanded(
          child: OutlinedButton(
            onPressed: () =>
                context.read<PaymentMethodCubit>().deletePaymentMethod(
                      customerId: customerId,
                      methodId: methodId,
                    ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const ResponsiveText(
              'Delete Card',
              fontSize: 13,
            ),
          ),
        ),
        ResponsiveGap.horizontal(14),

        /// Update Expiry
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const ResponsiveText(
              'Update Expire Date',
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
