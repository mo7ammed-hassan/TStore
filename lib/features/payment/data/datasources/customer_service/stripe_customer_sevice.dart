import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/i_customer_service.dart';
import 'package:t_store/features/payment/data/models/customer/customer_model.dart';

class StripeCustomerService implements ICustomerService {
  final ApiClient dio = ApiClient();

  @override
  Future<CustomerModel> createCustomer(
      {required CustomerModel customerData}) async {
    final response = await dio.post(
      ApiConstants.createCustomer,
      data: customerData.toJson(),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final customer = CustomerModel.fromJson(response.data);

    return customer;
  }

  @override
  Future<void> deleteCustomer(String customerId) async {
    await dio.delete(
      '${ApiConstants.deleteCustomer}$customerId',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
  }

  @override
  Future<CustomerModel?> getCustomer(String customerId) async {
    final response = await dio.delete(
      '${ApiConstants.retrieveCustomer}$customerId',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final customer = CustomerModel.fromJson(response.data);

    return customer;
  }
}
