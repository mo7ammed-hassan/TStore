import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/checkout/data/mapper/order_mapper.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/shop/features/order/data/datasources/order_remote_data_sources.dart';
import 'package:t_store/features/shop/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final OrderRemoteDataSources _orderRemoteDataSources;
  OrderRepositoryImpl(this._orderRemoteDataSources);

  @override
  Future<Either<Failure, List<OrderEntity>>> fetchAllOrders() async {
    try {
      final orders =
          await _orderRemoteDataSources.fetchAllOrders(userId: userId);

      final ordersList = orders
          .map(
            (e) => e.toEntity(),
          )
          .toList();

      return Right(ordersList);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Firebase error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelOrder({required String orderId}) async {
    try {
      await _orderRemoteDataSources.cancelOrder(
          orderId: orderId, userId: userId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Firebase error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
