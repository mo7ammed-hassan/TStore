import 'package:t_store/features/payment/data/datasources/i_card_flow_strategy.dart';

/// --- Stripe Shared Logic --- ///
abstract class BaseStripeCardFlowStrategy implements ICardFlowStrategy {
  // shared methods: createPaymentIntent, confirmPayment
}
