import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/domain/repository/personnel_auth_repository.dart';
import 'package:hr_self_service/src/ui/login/login_action.dart';
import 'package:hr_self_service/src/ui/login/login_state.dart';
import 'package:hr_self_service/src/domain/utils/validator.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final Ref ref;
  final PersonnelAuthRepository authRepo;

  LoginViewModel(this.ref, this.authRepo) : super(LoginState());

  Future<void> onAction(LoginAction action) async {
    switch (action) {
      
      case OnLoginClick():
        await _login(action.email, action.password);

      case OnTogglePasswordVisibility():
        _togglePasswordVisibility();
    }
  }

  Future<void> _login(String email, String password) async {
    final isComboValid = isEmailAndPasswordValid(email, password);
    if (isComboValid == ValidatorState.valid) {
      try {
        state = state.copy(
          email: email,
          password: password,
          isComboValid: true,
          isLoading: true,
          error: null
        );

        final user = await authRepo.login(email, password);
        final errorMessage = user == null ? 'Login failed. Please check your credentials.' : '';
        
        state = state.copy(
          isLoading: false,
          isLoginSuccessful: errorMessage.isEmpty ? true : false,
          error: errorMessage
        );
      } catch (e) {
        print(e);
        state = state.copy(
          isLoading: false,
          error: 'An error occurred. Please try again.'
        );
      }
    } else {
      state = state.copy(
        isComboValid: false,
        error: isComboValid.message
      );
    }
  }

  void _togglePasswordVisibility() {
    state = state.copy(
      isPasswordHidden: !state.isPasswordHidden
    );
  }
}