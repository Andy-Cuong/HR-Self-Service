class LoginState {
  final String email;
  final String password;
  final bool isComboValid;
  final bool isPasswordHidden;
  final bool isLoading;
  final bool isLoginSuccessful;
  final String error;

  LoginState({
    this.email = '',
    this.password = '',
    this.isComboValid = false,
    this.isPasswordHidden = true,
    this.isLoading = false,
    this.isLoginSuccessful = false,
    this.error = '',
  });

  LoginState copy({
    String? email,
    String? password,
    bool? isComboValid,
    bool? isPasswordHidden,
    bool? isLoading,
    bool? isLoginSuccessful,
    String? error,
  }) => LoginState(
    email: email ?? this.email,
    password: password ?? this.password,
    isComboValid: isComboValid ?? this.isComboValid,
    isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    isLoading: isLoading ?? this.isLoading,
    isLoginSuccessful: isLoginSuccessful ?? this.isLoginSuccessful,
    error: error ?? this.error,
  );
}