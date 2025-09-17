import 'package:t_store/features/payment/data/models/customer/customer_model.dart';

// -- contract (service interface) --
// Pattern: Interface Segregation Principle (ISP) + Dependency Inversion Principle (DIP).
abstract class ICustomerService {
  Future<CustomerModel> createCustomer({required CustomerModel customerData});
  Future<CustomerModel> updateCustomer({required CustomerModel customerData});
  Future<CustomerModel?> getCustomer(String? customerId);
}
