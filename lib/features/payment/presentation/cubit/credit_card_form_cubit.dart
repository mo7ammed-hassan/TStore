import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:t_store/features/payment/presentation/cubit/credit_card_form_state.dart';

class CreditCardFormCubit extends Cubit<CreditCardFormState> {
  CreditCardFormCubit() : super(CreditCardFormState());

  final formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel? model) {
    if (model == null) return;
    emit(state.copyWith(
      cardNumber: model.cardNumber,
      expiryDate: model.expiryDate,
      cardHolderName: model.cardHolderName,
      cvvCode: model.cvvCode,
      isCvvFocused: model.isCvvFocused,
    ));
  }

  void toggleSaveCard() {
    emit(state.copyWith(saveCard: !state.saveCard));
  }
}
