abstract class CheckoutState{}

class CheckoutInitial extends CheckoutState{}

class ChangePaymentMethodState extends CheckoutState{}

class CheckoutSuccessState extends CheckoutState{
}

class CheckoutErrorState extends CheckoutState{
  final String errorMessage;

  CheckoutErrorState(this.errorMessage);  
}

class CheckoutLoadingState extends CheckoutState{}