import 'package:t_store/features/payment/data/models/customer/customer_model.dart';

abstract class ICustomerService {
  Future<CustomerModel> createCustomer({required CustomerModel customerData});
  Future<CustomerModel?> getCustomer(String? customerId);
  Future<void> deleteCustomer(String customerId);
}


