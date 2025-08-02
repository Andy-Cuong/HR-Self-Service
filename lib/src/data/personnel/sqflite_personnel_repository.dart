import 'dart:async';

import 'package:hr_self_service/src/models/personnel.dart';
import 'package:hr_self_service/src/repository/personnel_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqflitePersonnelRepository implements PersonnelRepository {
  final Database database;

  SqflitePersonnelRepository(this.database);

  @override
  Future<int> addPersonnel(Personnel personnel) async {
    return await database.insert('personnel', personnel.toJson());
  }

  @override
  Future<int> deletePersonnel(int id) async {
    return await database.delete('personnel', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Stream<List<Personnel>> getAllPersonnel() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      List<Map<String, dynamic>> personnels = await database.query('personnel');
      yield personnels.map((json) => Personnel.fromJson(json)).toList();
    }
  }

  @override
  Future<Personnel?> getPersonnelById(int id) async {
    List<Map<String, dynamic>> queryPersonnels = await database.query(
      'personnel',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (queryPersonnels.isNotEmpty) {
      return Personnel.fromJson(queryPersonnels.first);
    }
    return null;
  }

  @override
  Future<int> updatePersonnel(int id, Personnel personnel) async {
    return await database.update(
      'personnel',
      personnel.toJson(),
      where: 'id = ?',
      whereArgs: [id]
    );
  }

}