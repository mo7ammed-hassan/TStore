import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:t_store/features/checkout/data/mapper/checout_mapper.dart';
import 'package:t_store/features/checkout/data/mapper/order_mapper.dart';
import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/core/utils/constants/enums.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource _checkoutRemoteDataSource;

  CheckoutRepositoryImpl(this._checkoutRemoteDataSource);
  final String? _getUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<OrderEntity> createOrderDraft(
      {required CheckoutEntity checkoutData}) async {
    final order = await _checkoutRemoteDataSource.createOrderDraft(
      checkoutData: checkoutData.toModel(),
      userId: _getUserId!,
    );

    return order.toEntity();
  }

  @override
  Future<CheckoutEntity> syncCartWithServer(
      {required List<CartItemEntity> itemsPayload}) async {
    final checkoutData = await _checkoutRemoteDataSource.syncCartWithServer(
      itemsPayload: itemsPayload,
    );

    return checkoutData.toEntity();
  }

  @override
  Future<void> updateOrderPaymentStatus({
    required String orderId,
    required PaymentStatus newStatus,
  }) async {
    await _checkoutRemoteDataSource.updateOrderPaymentStatus(
      orderId: orderId,
      newStatus: newStatus,
      userId: _getUserId!,
    );
  }
}
