import 'package:hr_self_service/src/models/personnel.dart';
import 'package:hr_self_service/src/repository/personnel_auth_repository.dart';

class MockPersonnelAuthRepository implements PersonnelAuthRepository {


  @override
  Future<void> changePassword(String oldPassword, String newPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Personnel?> getCurrentPersonnel() {
    // TODO: implement getCurrentPersonnel
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() {
    // TODO: implement isAuthenticated
    throw UnimplementedError();
  }

  @override
  Future<Personnel?> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(Personnel personnel) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
