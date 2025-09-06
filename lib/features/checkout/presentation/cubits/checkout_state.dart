import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';

enum CheckoutStatus { initial, loading, success, failure }

class CheckoutState {
  final CheckoutStatus status;
  final CheckoutEntity? checkoutData;
  final String message;
  final bool createOrderLoading;
  final bool createOrderSuccess;
  final OrderEntity? order;
  final AddressEntity? address;
  final String createOrderError;
  final bool loadAddress;

  CheckoutState({
    this.status = CheckoutStatus.initial,
    this.checkoutData,
    this.order,
    this.message = '',
    this.createOrderLoading = false,
    this.createOrderSuccess = false,
    this.address,
    this.createOrderError = '',
    this.loadAddress = false,
  });

  // CopyWith method for immutability
  CheckoutState copyWith({
    CheckoutStatus? status,
    CheckoutEntity? checkoutData,
    String? message,
    OrderEntity? order,
    bool? createOrderLoading,
    bool? createOrderSuccess,
    AddressEntity? address,
    String? createOrderError,
    bool? loadAddress,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      checkoutData: checkoutData ?? this.checkoutData,
      message: message ?? this.message,
      order: order ?? this.order,
      address: address ?? this.address,
      createOrderLoading: createOrderLoading ?? this.createOrderLoading,
      createOrderSuccess: createOrderSuccess ?? this.createOrderSuccess,
      createOrderError: createOrderError ?? this.createOrderError,
      loadAddress: loadAddress ?? this.loadAddress,
    );
  }
}
