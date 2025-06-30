import 'package:hr_self_service/src/models/personnel.dart';

abstract class PersonnelAuthRepository {
  Future<Personnel?> login(String email, String password);
  Future<void> logout();
  Future<Personnel?> getCurrentPersonnel();
  Future<bool> isAuthenticated();
  Future<void> updateProfile(Personnel personnel);
  Future<void> changePassword(String oldPassword, String newPassword);
}