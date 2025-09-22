import 'package:hr_self_service/src/domain/models/leave_application.dart';
import 'package:hr_self_service/src/domain/models/personnel.dart';

abstract class PersonnelRepository {
  Future<void> fetchPersonnel();
  Stream<List<Personnel>> getAllPersonnel();
  Future<Personnel?> getPersonnelById(int id);
  Future<int> addPersonnel(Personnel personnel);
  Future<int> updatePersonnel(int id, Personnel personnel);
  Future<int> deletePersonnel(int id);
  Future<bool> checkInPersonnel(int id, String qrCodeValue);
  Future<String?> sendLeaveApplication(LeaveApplication leaveApplication);
}