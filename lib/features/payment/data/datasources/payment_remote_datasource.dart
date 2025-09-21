import 'package:t_store/features/payment/core/payment_options/payment_methods.dart';
import 'package:t_store/features/payment/data/models/payment_service_model.dart';
import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';

abstract class PaymentRemoteDatasource {
  Future<List<CardMethodEntity>> getAvailableMethods();
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  @override
  Future<List<CardMethodEntity>> getAvailableMethods() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final methods = PaymentMethodsList.methods;
    return methods.map((e) => e.toEntity()).toList();
  }
}
