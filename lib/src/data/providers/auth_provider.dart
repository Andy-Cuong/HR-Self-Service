import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/domain/repository/personnel_auth_repository.dart';
import 'package:hr_self_service/src/data/auth/mock_personnel_auth_repository.dart';
import 'package:hr_self_service/src/data/services/dio_client.dart';
import 'package:hr_self_service/src/data/services/token_storage_service.dart';

// Provide TokenStorageService
final storageServiceProvider = Provider<StorageService>((ref) => StorageService());

// Provide DioClient, depending on TokenStorageService
final dioClientProvider = Provider<DioClient>(
  (ref) => DioClient(ref.read(storageServiceProvider))
);

// Provide the repository, depending on both services
final mockPersonnelAuthRepository = Provider<PersonnelAuthRepository>(
  (ref) => MockPersonnelAuthRepository(
    ref.read(storageServiceProvider),
    ref.read(dioClientProvider)
  )
);