abstract class LaunchAppState {}

class LaunchAppInitial extends LaunchAppState {}

class FirstLaunchState extends LaunchAppState {}
// -------Authentication states-------

class UnAuthenticatedState extends LaunchAppState {}

class AuthenticatedState extends LaunchAppState {}

class LaunchAppErrorState extends LaunchAppState {}

class VerifingEmailState extends LaunchAppState {
  final String? email;

  VerifingEmailState(this.email);
}
