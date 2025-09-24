import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/checkout/domain/usecases/checkout_usecases.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/get_selected_address_usecase.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/core/utils/constants/enums.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.checoutUsecases) : super(CheckoutState());
  final CheckoutUsecases checoutUsecases;

  Future<void> init(List<CartItemEntity> items) async {
    await Future.wait<void>([
      loadCheckout(items).catchError((_) {}),
      loadSelectedAddress().catchError((_) {}),
    ]);
  }

  Future<void> loadCheckout(List<CartItemEntity> items) async {
    emit(state.copyWith(status: CheckoutStatus.loading));

    try {
      CheckoutEntity checkoutData =
          await checoutUsecases.syncCartWithServerUseCase(items);

      emit(state.copyWith(
        status: CheckoutStatus.success,
        checkoutData: checkoutData,
      ));
    } catch (e) {
      emit(state.copyWith(status: CheckoutStatus.failure));
    }
  }

  Future<void> createOrderDraft(CheckoutEntity checkoutData,
      [OrderEntity? order]) async {
    if ((state.order?.orderId != null &&
            state.order?.orderStatus == OrderStatus.unCompleted.name) ||
        (order != null && order.orderStatus == OrderStatus.unCompleted.name)) {
      emit(state.copyWith(createOrderSuccess: true));
      return;
    }

    emit(state.copyWith(createOrderLoading: true, createOrderSuccess: false));
    try {
      final newOrder =
          await checoutUsecases.createOrderDraftUsecase(checkoutData);

      emit(
        state.copyWith(
          createOrderLoading: false,
          createOrderSuccess: true,
          order: newOrder,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        createOrderLoading: false,
        createOrderError: e.toString(),
      ));
    }
  }

  Future<void> loadSelectedAddress() async {
    emit(state.copyWith(loadAddress: true));

    final addressUsecases = getIt<GetSelectedAddressUsecase>();
    try {
      final selectedAddress = await addressUsecases.call();
      emit(state.copyWith(address: selectedAddress, loadAddress: false));
    } catch (e) {
      emit(state.copyWith(loadAddress: false));
    }
  }

  void chengeAdress(AddressEntity? address) {
    if (state.address != address) {
      emit(state.copyWith(address: address));
    }
  }
}
