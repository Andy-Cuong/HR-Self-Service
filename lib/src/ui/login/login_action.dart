sealed class LoginAction {}

class OnLoginClick extends LoginAction {
  final String email;
  final String password;

  OnLoginClick({
    this.email = '',
    this.password = ''
  });
}

class OnTogglePasswordVisibility extends LoginAction {}