import 'package:dio/dio.dart';
import 'package:hr_self_service/src/models/personnel.dart';
import 'package:hr_self_service/src/repository/personnel_auth_repository.dart';
import 'package:hr_self_service/src/services/dio_client.dart';
import 'package:hr_self_service/src/services/token_storage_service.dart';

class MockPersonnelAuthRepository implements PersonnelAuthRepository {
  final TokenStorageService tokenStorageService;
  final DioClient dioClient;

  Personnel? _currentPersonnel;

  MockPersonnelAuthRepository(this.tokenStorageService, this.dioClient);

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    // Mock: Always succeed
    return;
  }

  @override
  Future<Personnel?> getCurrentPersonnel() async {
    return _currentPersonnel;
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await tokenStorageService.getAccessToken();
    return token != null;
  }

  @override
  Future<Personnel?> login(String email, String password) async {
    // Mock: Use 'george.bluth@reqres.in' as email and any password, return a mock Personnel and save tokens
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await dioClient.dio.post(
          'https://reqres.in/api/login',
          data: {
            'email': email,
            'password': password
          }
        );
        final token = response.data['token'];
        await tokenStorageService.saveTokens(token, 'mock_refresh_token');
        
        _currentPersonnel = Personnel(
          name: 'Mock User',
          title: 'Developer', 
          email: email, 
          phoneNumber: '0123789456'
        );
        
        return _currentPersonnel;
      } on DioException catch (e) {
        // Error handling
        print(e.response);
        return null;
      }
    }

    return null;
  }

  @override
  Future<void> logout() async {
    await dioClient.dio.post(
      'https://reqres.in/api/logout'
    );
    _currentPersonnel = null;
    await tokenStorageService.clearTokens();
  }

  @override
  Future<void> updateProfile(Personnel personnel) async {
    _currentPersonnel = personnel;
  }
}
