import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/providers/auth_provider.dart';
import 'package:hr_self_service/src/ui/login/login_state.dart';
import 'package:hr_self_service/src/ui/login/login_viewmodel.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(
    ref.read(mockPersonnelAuthRepository)
  ),
);