import 'package:hr_self_service/src/models/personnel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const tablePersonnel = 'personnel';

Future<Database> openPersonnelDatabase() async {
  final dbPath = await getDatabasesPath();
  return openDatabase(
    join(dbPath, 'personnel_database.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tablePersonnel(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          title TEXT,
          email TEXT,
          phoneNumber TEXT
        )''',
      );

      final personnelList = await PersonnelModel.loadPersonnelFromJson();
      for (final personnel in personnelList) {
        await db.insert(tablePersonnel, personnel.toJson());
      }
    },
  );
}