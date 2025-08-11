import 'package:local_auth/local_auth.dart';

class AppLockService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to unlock the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false
        )
      );
    } catch (e) {
      return false;
    }
  }
}