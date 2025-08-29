/// Switch of Custom Brand-Text-Size Widget
///
enum ProductType { single, variable }

enum TextSizes { small, medium, large }

enum OrderStatus {
  unCompleted,
  processing,
  shipped,
  delivered,
  cancelled,
}

enum PaymentStatus { pendingPayment, paidPayment, cashPayment }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm
}
