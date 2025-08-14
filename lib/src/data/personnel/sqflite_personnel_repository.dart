import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hr_self_service/src/domain/data_source/remote_data_source.dart';
import 'package:hr_self_service/src/domain/models/personnel.dart';
import 'package:hr_self_service/src/domain/repository/personnel_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqflitePersonnelRepository implements PersonnelRepository {
  final RemoteDataSource remoteDataSource;
  final Database database;
  final connectivity = Connectivity();

  final _personnelController = StreamController<List<Personnel>>.broadcast();

  SqflitePersonnelRepository(this.remoteDataSource, this.database) {
    // Listen to connectivity changes
    connectivity.onConnectivityChanged.listen((statuses) async {
      if (statuses.any((status) => status != ConnectivityResult.none)) { // Status changes to online
        await fetchPersonnel();
      }
      _emitPersonnel();
    });

    // Emit initial data
    _emitPersonnel();
  }

  /// Helper function to notify the [StreamController] _personnelController of new data
  void _emitPersonnel() async {
    try {
      final personnelList = await database.query('personnel');
      _personnelController.add(
        personnelList.map((personnel) => Personnel.fromJson(personnel)).toList()
      );
    } catch (e, stack) {
      print('Error query personnel table: $e');
      print('Stack trace: $stack');
    }
  }

  @override
  Future<void> fetchPersonnel() async {
    try {
      final remoteList = await remoteDataSource.fetchPersonnel();
      // Start a transaction
      await database.transaction((tsn) async { 
        
        await tsn.delete('personnel'); // Delete all existing records, but not the table itself
      
        for (final personnel in remoteList) {
          await tsn.insert('personnel', personnel.toJson());
        }
      });
    } catch (e, stack) {
      print('Error adding personnel: $e');
      print('Stack trace: $stack');
    }
  }

  @override
  Stream<List<Personnel>> getAllPersonnel() => _personnelController.stream;

  @override
  Future<Personnel?> getPersonnelById(int id) async {
    try {
      List<Map<String, dynamic>> queryPersonnels = await database.query(
        'personnel',
        where: 'id = ?',
        whereArgs: [id],
      );
      
      if (queryPersonnels.isNotEmpty) {
        return Personnel.fromJson(queryPersonnels.first);
      }
    } catch (e, stack) {
      print('Error getting personnel: $e');
      print('Stack trace: $stack');
    }

    return null;
  }

  @override
  Future<int> addPersonnel(Personnel personnel) async {
    try {
      final result = await database.insert('personnel', personnel.toJson());
      _emitPersonnel();

      if (result != 0) {
        remoteDataSource.addPersonnel(personnel);
      }

      return result;
    } catch (e, stack) {
      print('Error adding personnel: $e');
      print('Stack trace: $stack');
      return -1;
    }
  }

  @override
  Future<int> updatePersonnel(int id, Personnel personnel) async {
    try {
      final result = await database.update(
        'personnel',
        personnel.toJson(),
        where: 'id = ?',
        whereArgs: [id]
      );
      _emitPersonnel();

      if (result > 0) {
        remoteDataSource.updatePersonnel(id, personnel);
      }

      return result;
    } catch (e, stack) {
      print('Error updating personnel: $e');
      print('Stack trace: $stack');
      return -1;
    }
  }

  @override
  Future<int> deletePersonnel(int id) async {
    try {
      final result = await database.delete('personnel', where: 'id = ?', whereArgs: [id]);
      _emitPersonnel();

      if (result > 0) {
        remoteDataSource.deletePersonnel(id);
      }

      return result;
    } catch (e, stack) {
      print('Error deleting personnel: $e');
      print('Stack trace: $stack');
      return -1;
    }
  }

  void dispose() {
    _personnelController.close();
  }
}