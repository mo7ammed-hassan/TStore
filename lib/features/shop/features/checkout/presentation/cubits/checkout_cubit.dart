import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_managment_service.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/checkout/data/models/payment_method_model.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/shop/features/order/data/models/order_model.dart';
import 'package:t_store/features/shop/features/order/data/repositories/order_repository.dart';
import 'package:t_store/features/shop/features/order/data/source/order_firebase_service.dart';
import 'package:t_store/features/shop/features/order/domain/repositories/order_repository.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/enums.dart';

import 'package:t_store/utils/constants/images_strings.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  PaymentMethodModel? selectedPaymentMethod;
  AddressModel? selectedAddress;
  List<CartItemEntity> cartItems = getIt.get<CartCubit>().cartItemsList;

  final OrderRepository orderRepository = OrderRepositoryImpl(
    OrderFirebaseServiceImpl(),
  );

  // change payment method
  void initPaymentMethod() {
    selectedPaymentMethod =
        const PaymentMethodModel(name: 'Paypal', image: TImages.paypal);
  }

  // change payment method
  void changePaymentMethod({required PaymentMethodModel paymentMethod}) {
    selectedPaymentMethod = paymentMethod;
    emit(ChangePaymentMethodState());
  }

  // checkout
  Future<void> checkout() async {
    emit(CheckoutLoadingState());
    if (selectedAddress == null || selectedAddress!.name.isEmpty) {
      emit(CheckoutErrorState('Please select an address'));
      return;
    }

    if (selectedPaymentMethod!.name.isEmpty ||
        selectedPaymentMethod?.name == '') {
      emit(CheckoutErrorState('Please select a payment method'));
      return;
    }

    if (cartItems.isEmpty) {
      emit(CheckoutErrorState('Cart is empty'));
      return;
    }

    try {
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: FirebaseAuth.instance.currentUser!.uid,
        status: OrderStatus.processing,
        totalAmount: calculateTotalAmount(),
        orderDate: DateTime.now(),
        address: selectedAddress!,
        deliveryDate: DateTime.now().add(const Duration(days: 2)),
        cartItems: cartItems,
        paymentMethod: selectedPaymentMethod!.name,
      );

      await orderRepository.placeOrder(order: order);
      await getIt.get<CartManagementService>().removeAllItemsFromCart();
      await Future.delayed(const Duration(seconds: 1));
      emit(CheckoutSuccessState());
    } catch (e) {
      emit(CheckoutErrorState(e.toString()));
    }
  }

  double calculateSubTotalAmount() {
    double subtotal = 0.0;
    subtotal = getIt.get<CartCubit>().calculateTotalPrice();
    return subtotal;
  }

  double calculateTotalAmount() {
    double total = 0.0;
    total = getIt.get<CartCubit>().calculateTotalPrice();
    return double.parse((total + 10 + 6).toStringAsFixed(2));
  }
}
