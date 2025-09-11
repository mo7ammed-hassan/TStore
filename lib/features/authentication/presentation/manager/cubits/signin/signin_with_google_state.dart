abstract class SignInWithGoogleState {}

class SignInWithGoogleInitialState extends SignInWithGoogleState {}

class SignInWithGoogleLoadingState extends SignInWithGoogleState {}

class SignInWithGoogleSuccessState extends SignInWithGoogleState {
  final String successMessage;

  SignInWithGoogleSuccessState(this.successMessage);
}

class SignInWithGoogleFaliureState extends SignInWithGoogleState {
  final String errorMessage;

  SignInWithGoogleFaliureState(this.errorMessage);
}

class NotVerifiedEmailState extends SignInWithGoogleState {
  final String email;

  NotVerifiedEmailState(this.email);
}
