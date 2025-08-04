ValidatorState isEmailAndPasswordValid(String email, String password) {
  if (email.isEmpty) return ValidatorState.emailEmpty;
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(email)) return ValidatorState.emailInvalid;

  if (password.length < 8) return ValidatorState.passwordTooShort;

  return ValidatorState.valid;
}

enum ValidatorState {
  emailEmpty('Email is required'),
  emailInvalid('Email is invalid'),
  passwordTooShort('Password is too short'),
  valid('Valid');

  final String message;
  const ValidatorState(this.message);
}