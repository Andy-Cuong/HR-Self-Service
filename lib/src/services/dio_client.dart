import 'package:dio/dio.dart';
import 'token_storage_service.dart';

class DioClient {
  final Dio dio = Dio();
  final TokenStorageService tokenStorageService;

  DioClient(this.tokenStorageService) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenStorageService.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';        
        }

        handler.next(options);
      },
      onError: (DioException error, handler) async {
        // If 401 (Unauthorized), try to refresh token
        if (error.response?.statusCode == 401) {
          final refreshToken = await tokenStorageService.getRefreshToken();
          if (refreshToken != null) {
            try {
              // Call the refresh endpoint
            } catch (e) {
              await tokenStorageService.clearTokens();
              // Optionally, redirect to login
            }
          }
        }

        handler.next(error);
      },
    ));
  }
}