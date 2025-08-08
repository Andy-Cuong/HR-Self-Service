import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/personnel/dio_remote_data_source.dart';
import 'package:hr_self_service/src/data/personnel/sqflite_personnel_repository.dart';
import 'package:hr_self_service/src/data/providers/auth_provider.dart';
import 'package:hr_self_service/src/data/providers/database_provider.dart';
import 'package:hr_self_service/src/domain/data_source/remote_data_source.dart';
import 'package:hr_self_service/src/domain/repository/personnel_repository.dart';

final personnelRepositoryProvider = FutureProvider<PersonnelRepository>((ref) async {
  final database = await ref.watch(personnelDatabaseProvider.future);

  return SqflitePersonnelRepository(
    ref.read(remoteDataSourceProvider),
    database,
    Connectivity()
  );
});

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) =>
  DioRemoteDataSource(
    ref.read(dioClientProvider),
    ref.read(storageServiceProvider)
  )
);