class ApiConstants {
  const ApiConstants._();
  static const _stripeBaseUrl = 'https://api.stripe.com/v1';
  static const paymentIntents = '$_stripeBaseUrl/payment_intents';
  // -- Customers --
  static const customers = '$_stripeBaseUrl/customers';
  static const setupIntents = '$_stripeBaseUrl/setup_intents';
  static const paymentMethods = '$_stripeBaseUrl/payment_methods';


  // -- Payment Method --
  static String getCustomerPaymentMethods({required String? customerId}) =>
    '$_stripeBaseUrl/payment_methods?customer=$customerId&type=card';

}
