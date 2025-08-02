import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/database/personnel_database.dart';
import 'package:sqflite/sqflite.dart';

final personnelDatabaseProvider = FutureProvider<Database>((ref) async {
  return await openPersonnelDatabase();
});