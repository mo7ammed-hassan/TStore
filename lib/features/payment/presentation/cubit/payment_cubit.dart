import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/navigation_menu/navigation_screen.dart';
import 'package:t_store/features/payment/data/models/payment_method.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart'
    show PaymentState;
import 'package:t_store/features/payment/presentation/screens/payment_status_screen.dart';
import 'package:t_store/utils/constants/images_strings.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentState());

  void fetchPaymentMethods() async {
    emit(state.copyWith(loading: true));

    // Mock fetch (replace with API / Firestore)
    await Future.delayed(const Duration(milliseconds: 500));

    final methods = [
      const PaymentMethod(id: "1", name: "Credit Card", icon: TImages.visa),
      const PaymentMethod(id: "2", name: "PayPal", icon: TImages.paypal),
      const PaymentMethod(
          id: "3", name: "Cash on Delivery", icon: TImages.creditCard),
    ];

    emit(state.copyWith(methods: methods, loading: false));
  }

  void selectMethod(PaymentMethod method) {
    emit(state.copyWith(selected: method));
  }

  void confirmPayment(BuildContext context) {
    if (state.selected == null) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentStatusScreen(
          imagePath: TImages.successPyment,
          animation: true,
          paymentSuccess: true,
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const NavigationScreen()),
            (route) => false,
          ),
        ),
      ),
      (route) => false,
    );
  }
}
