class ApiConstants {
  const ApiConstants._();
  static const stripeBaseUrl = 'https://api.stripe.com/v1';
  static const paymentIntents = '$stripeBaseUrl/payment_intents';
  // -- Customers -- 
  static const createCustomer = '$stripeBaseUrl/customers';
  static const deleteCustomer = '$stripeBaseUrl/customers';
  static const retrieveCustomer = '$stripeBaseUrl/customers/';
}
