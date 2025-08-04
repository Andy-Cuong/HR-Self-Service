import 'package:hr_self_service/src/domain/models/personnel.dart';

abstract class RemoteDataSource {
  Future<List<Personnel>> fetchPersonnel();
}