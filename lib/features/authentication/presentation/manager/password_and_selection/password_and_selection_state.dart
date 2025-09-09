class PasswordAndSelectionState {
  final bool isPasswordHidden;
  final bool isPrivacyAccepted;
  final bool isRememberMe;

  PasswordAndSelectionState({
    required this.isPasswordHidden,
    required this.isPrivacyAccepted,
    required this.isRememberMe,
  });

  PasswordAndSelectionState copyWith({
    bool? isPasswordHidden,
    bool? isPrivacyAccepted,
    bool? isRememberMe,
  }) {
    return PasswordAndSelectionState(
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isPrivacyAccepted: isPrivacyAccepted ?? this.isPrivacyAccepted,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
}
