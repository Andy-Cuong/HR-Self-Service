import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/repository/personnel_auth_repository.dart';
import 'package:hr_self_service/src/repository/mock_personnel_auth_repository.dart';
import 'package:hr_self_service/src/services/dio_client.dart';
import 'package:hr_self_service/src/services/token_storage_service.dart';

// Provide TokenStorageService
final tokenStorageServiceProvider = Provider<TokenStorageService>((ref) => TokenStorageService());

// Provide DioClient, depending on TokenStorageService
final dioClientProvider = Provider<DioClient>(
  (ref) => DioClient(ref.read(tokenStorageServiceProvider))
);

// Provide the repository, depending on both services
final mockPersonnelAuthRepository = Provider<PersonnelAuthRepository>(
  (ref) => MockPersonnelAuthRepository(
    ref.read(tokenStorageServiceProvider),
    ref.read(dioClientProvider)
  )
);