import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/checkout/domain/usecases/checkout_usecases.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/utils/constants/enums.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.checoutUsecases) : super(CheckoutState());
  final CheckoutUsecases checoutUsecases;

  Future<void> loadCheckout(List<CartItemEntity> items) async {
    emit(state.copyWith(isLoading: true));

    try {
      CheckoutEntity checkoutData =
          await checoutUsecases.syncCartWithServerUseCase(items);

      emit((state.copyWith(isLoading: false, checkoutData: checkoutData)));
    } catch (e) {
      emit(state.copyWith(isLoading: false, checkoutData: null));
    }
  }

  Future<void> createOrderDraft(CheckoutEntity checkoutData) async {
    if (state.order?.orderId != null &&
        state.order?.orderStatus == OrderStatus.unCompleted.name) {
      emit(
        state.copyWith(
          createOrderSuccess: true,
        ),
      );
      return;
    }

    emit(state.copyWith(createOrderLoading: true, createOrderSuccess: false));
    try {
      final order = await checoutUsecases.createOrderDraftUsecase(checkoutData);

      emit(
        state.copyWith(
          createOrderLoading: false,
          createOrderSuccess: true,
          order: order,
        ),
      );
    } catch (e) {
      emit(state.copyWith(createOrderLoading: false));
    }
  }
}
