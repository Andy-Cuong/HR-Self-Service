import 'package:hr_self_service/src/models/personnel.dart';

abstract class PersonnelRepository {
  Stream<List<Personnel>> getAllPersonnel();
  Future<Personnel?> getPersonnelById(int id);
  Future<int> addPersonnel(Personnel personnel);
  Future<int> updatePersonnel(int id, Personnel personnel);
  Future<int> deletePersonnel(int id);
}