import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/common/common.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/domain/entities/card_details_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_user_data_entity.dart';
import 'package:t_store/features/payment/presentation/widgets/option_payment_checkbox.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/payment/payment.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({super.key, this.entryPoint});
  final PaymentEntryPoint? entryPoint;

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)?.settings.arguments as OrderEntity?;

    return Scaffold(
      appBar: const TAppBar(
        title: 'Add Payment Method',
        showBackArrow: true,
        nestedNavigator: true,
      ),
      body: BlocProvider(
        create: (context) => CreditCardFormCubit(),
        child: CreditCardView(order: order, entryPoint: entryPoint),
      ),
    );
  }
}

class CreditCardView extends StatelessWidget {
  const CreditCardView({super.key, required this.order, this.entryPoint});
  final OrderEntity? order;
  final PaymentEntryPoint? entryPoint;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final cubit = context.watch<CreditCardFormCubit>();
    final formKey = cubit.formKey;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreditCardWidget(
                    // cardBgColor:
                    //     isDark ? Colors.black87 : const Color(0xff1b447b),
                    glassmorphismConfig:
                        isDark ? Glassmorphism.defaultConfig() : null,
                    cardNumber: cubit.state.cardNumber,
                    expiryDate: cubit.state.expiryDate,
                    cardHolderName: cubit.state.cardHolderName,
                    cvvCode: cubit.state.cvvCode,
                    bankName: 'Axis Bank',
                    showBackView: cubit.state.isCvvFocused,
                    obscureCardNumber: false,
                    obscureCardCvv: false,
                    isHolderNameVisible: true,
                    isChipVisible: true,
                    enableFloatingCard: true,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange: (_) {},
                  ),
                  ResponsiveGap.vertical(20),
                  Padding(
                    padding: context.responsiveInsets.only(left: 14),
                    child: const ResponsiveText(
                      'Card Details',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: false,
                    obscureNumber: false,
                    cardNumber: cubit.state.cardNumber,
                    cvvCode: cubit.state.cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cubit.state.cardHolderName,
                    expiryDate: cubit.state.expiryDate,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    onCreditCardModelChange: cubit.onCreditCardModelChange,
                  ),
                  ResponsiveGap.vertical(18),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        const OptionCheckbox(
                          title: 'Billing is same as shipping information',
                          value: true,
                        ),
                        ResponsiveGap.vertical(8),
                        OptionCheckbox(
                          title: 'Save Payment details for future purchases',
                          value: context.select(
                            (CreditCardFormCubit cubit) => cubit.state.saveCard,
                          ),
                          onChanged: (val) => cubit.toggleSaveCard(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _PayButton(
            key: const ValueKey('PayWithNewCardButton'),
            order: order,
          ),
        ],
      ),
    );
  }
}

class _PayButton extends StatelessWidget {
  const _PayButton({super.key, required this.order});
  final OrderEntity? order;

  @override
  Widget build(BuildContext context) {
    final cardCubit = context.read<CreditCardFormCubit>();
    final paymentCubit = context.read<PaymentCubit>();
    final user = context.read<UserCubit>().state.user;

    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: context.responsiveInsets
                .symmetric(horizontal: 24, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (!cardCubit.formKey.currentState!.validate()) return;

                final data = cardCubit.state.expiryDate.split('/');
                final expMonth = int.tryParse(data[0]) ?? 0;
                final expYear = int.tryParse(data[1]) ?? 0;

                final cardDetails = CardDetailsEntity(
                  cardNumber: cardCubit.state.cardNumber,
                  expMonth: expMonth,
                  expYear: expYear,
                  cvcCode: cardCubit.state.cvvCode,
                );

                final shippingAddress = Address(
                  city: order?.shippingAddress?.city,
                  country: '',
                  line1: order?.shippingAddress?.street,
                  line2: '',
                  postalCode: order?.shippingAddress?.postalCode,
                  state: order?.shippingAddress?.state,
                );

                final userData = PaymentUserDataEntity(
                  name: user?.fullName,
                  email: user?.userEmail,
                  phone: user?.userPhone,
                  address: shippingAddress,
                  customerId: user?.stripeCustomerId,
                );

                final details = PaymentDetailsEntity(
                  orderId: order!.orderId,
                  currency: 'usd',
                  amountMinor: order!.checkoutModel.total.toInt(),
                  cardDetails: cardDetails,
                  user: userData,
                  saveCard: cardCubit.state.saveCard,
                );

                paymentCubit.confirmPayment(
                  details,
                  order!,
                  cardFlow: CardFlow.newCard,
                );

                context.read<UserCubit>().fetchUserData(forchFetch: true);
              },
              child: const ResponsiveText('Pay'),
            ),
          ),
        );
      },
    );
  }
}
