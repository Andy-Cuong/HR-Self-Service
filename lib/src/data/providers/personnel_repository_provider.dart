import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/personnel/sqflite_personnel_repository.dart';
import 'package:hr_self_service/src/data/providers/database_provider.dart';
import 'package:hr_self_service/src/repository/personnel_repository.dart';

final personnelRepositoryProvider = FutureProvider<PersonnelRepository>((ref) async {
  final database = await ref.watch(personnelDatabaseProvider.future);

  return SqflitePersonnelRepository(database);
});