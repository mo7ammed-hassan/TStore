import 'package:t_store/features/payment/core/payment_options/payment_methods.dart';
import 'package:t_store/features/payment/data/mappers/payment_method_mapper.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';

abstract class PaymentRemoteDatasource {
  Future<List<PaymentMethodEntity>> getAvailableMethods();
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  @override
  Future<List<PaymentMethodEntity>> getAvailableMethods() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final methods = PaymentMethodsList.methods;
    return methods.map((e) => e.toEntity()).toList();
  }
}
