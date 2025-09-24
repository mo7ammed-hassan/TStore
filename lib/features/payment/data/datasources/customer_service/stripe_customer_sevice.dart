import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/features/payment/payment.dart';

// -- Layer: Infrastructure / Data Source Implementation. --
// -- Strategy Pattern & Open–Closed Principle (OCP) --
class StripeCustomerService implements ICustomerService {
  final ApiClient dio;
  StripeCustomerService(this.dio);

  @override
  Future<CustomerModel> createCustomer({
    required CustomerModel customerData,
  }) async {
    final stripeModel = StripeCustomerModel.fromCustomerModel(customerData);

    final response = await dio.post(
      ApiConstants.customers,
      data: stripeModel.toJson(),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final customer = CustomerModel.fromJson(response.data);
    return customer;
  }

  Future<void> deleteCustomer(String? customerId) async {
    if (customerId == null) return;
    await dio.delete(
      '${ApiConstants.customers}/$customerId',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
  }

  @override
  Future<CustomerModel?> getCustomer(String? customerId) async {
    final response = await dio.get(
      '${ApiConstants.customers}/$customerId',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final stripe = StripeCustomerModel.fromJson(response.data);
    return stripe.toCustomerModel();
  }

  @override
  Future<CustomerModel> updateCustomer({
    required CustomerModel customerData,
  }) async {
    final stripeModel = StripeCustomerModel.fromCustomerModel(customerData);

    final response = await dio.post(
      '${ApiConstants.customers}/${customerData.id}',
      data: stripeModel.toJson(),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final updated = StripeCustomerModel.fromJson(response.data);
    return updated.toCustomerModel();
  }
}
