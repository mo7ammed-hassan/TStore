import 'package:t_store/features/checkout/domain/usecases/create_order_draft_usecase.dart';
import 'package:t_store/features/checkout/domain/usecases/sync_cart_with_server_usecase.dart';
import 'package:t_store/features/checkout/domain/usecases/update_order_payment_status_usecase.dart';

class CheckoutUsecases {
  final SyncCartWithServerUseCase syncCartWithServerUseCase;
  final UpdateOrderPaymentStatusUsecase updateOrderPaymentStatusUsecase;
  final CreateOrderDraftUsecase createOrderDraftUsecase;

  CheckoutUsecases({
    required this.syncCartWithServerUseCase,
    required this.updateOrderPaymentStatusUsecase,
    required this.createOrderDraftUsecase,
  });
}
