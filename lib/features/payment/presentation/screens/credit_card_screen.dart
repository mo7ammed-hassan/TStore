import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/checkout/data/models/order_summary_model.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/core/constants/payment_images.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/payment/data/models/credit_card_details_model.dart';
import 'package:t_store/features/payment/data/models/payment_use_data.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/features/payment/presentation/cubit/credit_card_form_cubit.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/payment/presentation/screens/payment_status_screen.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_cubit.dart';
import 'package:t_store/features/shop/features/order/presentation/pages/order_page.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({super.key, this.entryPoint});
  final PaymentEntryPoint? entryPoint;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final order = args['order'] as OrderEntity;
    final paymentCubit = args['paymentCubit'] as PaymentCubit;

    return Scaffold(
      appBar: const TAppBar(
        title: 'Payment Method',
        showBackArrow: true,
        nestedNavigator: true,
      ),
      body: BlocProvider(
        create: (context) => CreditCardFormCubit(),
        child: CreditCardView(
          order: order,
          entryPoint: entryPoint,
          paymentCubit: paymentCubit,
        ),
      ),
    );
  }
}

class CreditCardView extends StatelessWidget {
  const CreditCardView({
    super.key,
    required this.order,
    this.entryPoint,
    required this.paymentCubit,
  });
  final OrderEntity? order;
  final PaymentCubit paymentCubit;
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
                  ResponsiveGap.vertical(20),
                  const _SaveCardCheckbox(),
                ],
              ),
            ),
          ),
          BlocProvider.value(
            value: paymentCubit,
            child: PayButton(order: order, entryPoint: entryPoint),
          ),
        ],
      ),
    );
  }
}

class _SaveCardCheckbox extends StatelessWidget {
  const _SaveCardCheckbox();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreditCardFormCubit>();

    return Padding(
      padding: context.responsiveInsets.only(left: 18),
      child: GestureDetector(
        onTap: cubit.toggleSaveCard,
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: context.horzSize(18),
              height: context.horzSize(18),
              decoration: BoxDecoration(
                color: cubit.state.saveCard ? AppColors.buttonPrimary : null,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: cubit.state.saveCard
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 8),
            const ResponsiveText('Save card', fontSize: 13),
          ],
        ),
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({super.key, required this.order, this.entryPoint});
  final OrderEntity? order;
  final PaymentEntryPoint? entryPoint;

  @override
  Widget build(BuildContext context) {
    final cardCubit = context.read<CreditCardFormCubit>();
    final user = context.read<UserCubit>().state.user;

    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state.action == PaymentAction.processPayment &&
            state.status == PaymentStateStatus.success) {
          if (entryPoint == PaymentEntryPoint.orderPage) {
            context.read<OrderCubit>().changeOrderStaus(order!);
          }
          final orderSummary = order?.checkoutModel.orderSummary
              .copyWith(transactionId: state.paymentResult?.transactionId);

          _onPaymentSuccess(context, orderSummary);
        } else if (state.action == PaymentAction.processPayment &&
            state.status == PaymentStateStatus.failure) {
          _onPaymentErro(context);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: context.responsiveInsets
                .symmetric(horizontal: 26, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (!cardCubit.formKey.currentState!.validate()) return;

                final data = cardCubit.state.expiryDate.split('/');
                final expMonth = int.tryParse(data[0]) ?? 0;
                final expYear = int.tryParse(data[1]) ?? 0;

                final cardDetails = CreditCardDetailsModel(
                  cardNumber: cardCubit.state.cardNumber,
                  expMonth: expMonth,
                  expYear: expYear,
                  cvvCode: cardCubit.state.cvvCode,
                );

                final shippingAddress = Address(
                  city: order?.shippingAddress?.city,
                  country: '',
                  line1: order?.shippingAddress?.street,
                  line2: '',
                  postalCode: order?.shippingAddress?.postalCode,
                  state: order?.shippingAddress?.state,
                );

                final userData = PaymentUserDataModel(
                  name: user?.fullName,
                  email: user?.userEmail,
                  phone: user?.userPhone,
                  address: shippingAddress,
                );

                final details = PaymentDetails(
                  orderId: order!.orderId,
                  currency: 'usd',
                  amountMinor: order!.checkoutModel.total.toInt(),
                  cardDetails: cardDetails,
                  user: userData,
                );

                context.read<PaymentCubit>().confirmPayment(details, order!);
              },
              child: state.status == PaymentStateStatus.loading &&
                      state.action == PaymentAction.processPayment
                  ? SizedBox(
                      width: context.horzSize(20),
                      height: context.horzSize(20),
                      child: const Center(
                        child: PopScope(
                          canPop: false,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        ),
                      ),
                    )
                  : const ResponsiveText('Pay'),
            ),
          ),
        );
      },
    );
  }

  void _onPaymentSuccess(
    BuildContext context,
    OrderSummaryModel? orderSummary,
  ) {
    Navigator.of(context, rootNavigator: false).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PaymentStatusScreen(
          orderSummary: orderSummary,
          onTap: () {
            if (entryPoint == PaymentEntryPoint.orderPage) {
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const OrderPage(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _onPaymentErro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentStatusScreen(
          title: 'Payment Failed',
          subTitle: 'Sorry your transaction could not processed',
          imagePath: PaymentImages.paymentFailed,
          paymentSuccess: false,
          buttonTitle: 'Back',
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
