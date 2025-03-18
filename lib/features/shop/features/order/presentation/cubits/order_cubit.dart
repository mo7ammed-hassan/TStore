import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/order/data/repositories/order_repository.dart';
import 'package:t_store/features/shop/features/order/data/source/order_firebase_service.dart';
import 'package:t_store/features/shop/features/order/presentation/cubits/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  final orderRepository = OrderRepositoryImpl(
    OrderFirebaseServiceImpl(),
  );

  //-- Fetch Orders Once --
  void fetchOrders() async {
    emit(OrderLoadingState());
    var result = await orderRepository.getAllOrders();
    result.fold(
      (failure) => emit(OrderFailureState(failure)),
      (orders) => emit(OrderSuccessState(orders)),
    );
  }

  //-- Refresh Orders --
  void refreshOrders() async {
    emit(OrderLoadingState());
    var result = await orderRepository.getAllOrders();
    result.fold(
      (failure) => emit(OrderFailureState(failure)),
      (orders) => emit(OrderSuccessState(orders)),
    );
  }
}
