import 'package:dio/dio.dart';
import 'package:hr_self_service/src/data/services/dio_client.dart';
import 'package:hr_self_service/src/data/services/storage_service.dart';
import 'package:hr_self_service/src/domain/data_source/remote_data_source.dart';
import 'package:hr_self_service/src/domain/models/leave_application.dart';
import 'package:hr_self_service/src/domain/models/personnel.dart';
import 'package:hr_self_service/src/domain/utils/hash.dart';

class DioRemoteDataSource implements RemoteDataSource {
  final DioClient dioClient;
  final StorageService storageService;

  DioRemoteDataSource(this.dioClient, this.storageService);

  @override
  Future<List<Personnel>> fetchPersonnel() async {
    try {
      final response = await dioClient.dio.get(
        'https://reqres.in/api/personnel'
      );

      if (response.statusCode! > 299) {
        print('Error: Code ${response.statusCode} - ${response.statusMessage}');
        return List.empty();
      } else {
        print('Successfully fetched remote data');
        // Mock remote data
        final personnelList = await PersonnelModel.loadPersonnelFromJson();
        return personnelList;
      }
    } on DioException catch (e) {
      // Error handling
      print(e);
      return List.empty();
    }
  }
  
  @override
  Future<int> addPersonnel(Personnel personnel) async {
    try {
      // Encrypt important fields before sending
      final secretKey = (await storageService.getData('hmac_secret'))!;

      final jsonPersonnel = personnel.toJson()
        ..['email'] = hmacSha256(personnel.email, secretKey)
        ..['phoneNumber'] = hmacSha256(personnel.phoneNumber, secretKey);

      final response = await dioClient.dio.put(
        'https://reqres.in/api/personnel/${personnel.id!}',
        data: jsonPersonnel
      );

      if (response.statusCode! > 299) {
        print('Error: Code ${response.statusCode} - ${response.statusMessage}');
        return -1;
      }
        
      print('Successfully added personnel');
      return personnel.id!;
    } on DioException catch (e) {
      // Error handling
      print(e);
      rethrow;
    }
  }
  
  @override
  Future<int> updatePersonnel(int id, Personnel personnel) async {
    try {
      // Encrypt important fields before sending
      final secretKey = (await storageService.getData('hmac_secret'))!;

      final jsonPersonnel = personnel.toJson()
        ..['email'] = hmacSha256(personnel.email, secretKey)
        ..['phoneNumber'] = hmacSha256(personnel.phoneNumber, secretKey);

      final response = await dioClient.dio.put(
        'https://reqres.in/api/personnel/$id',
        data: jsonPersonnel
      );

      if (response.statusCode! > 299) {
        print('Error: Code ${response.statusCode} - ${response.statusMessage}');
        return -1;
      }

      print('Successfully updated personnel with ID $id');
      return id;
    } on DioException catch (e) {
      // Error handling
      print(e);
      rethrow;
    }
  }

  @override
  Future<int> deletePersonnel(int id) async {
    try {
      final response = await dioClient.dio.delete(
        'https://reqres.in/api/personnel/$id'
      );

      if (response.statusCode! > 299) {
        print('Error: Code ${response.statusCode} - ${response.statusMessage}');
        return -1;
      }
        
      print('Successfully deleted personnel with ID $id');
      return id;
    } on DioException catch (e) {
      // Error handling
      print(e);
      rethrow;
    }
  }

  @override
  Future<bool> checkInPersonnel(int id, qrCodeValue) async {
    try {
      final response = await dioClient.dio.put(
        'https://reqres.in/api/checkin/$id',
        data: {'qr': qrCodeValue}
      );

      if (response.statusCode! > 299) {
        print('Error: Code ${response.statusCode} - ${response.statusMessage}');
        return false;
      }

      print('Successfully checked in at ${response.data['updatedAt']}');
      return true;
    } on DioException catch (e) {
      // Error handling
      print(e);
      return false;
    }
  }

  @override
  Future<String?> sendLeaveApplication(LeaveApplication leaveApplication) async {
    try {
      final response = await dioClient.dio.post(
        'https://reqres.in/api/leave',
        data: leaveApplication.toJson()
      );

      if (response.statusCode! > 299) {
        print('Error: Code ${response.statusCode} - ${response.statusMessage}');
        return null;
      }

      print('Successfully sent leave application. Application ID: ${leaveApplication.id}');
      return leaveApplication.id!;
    } on DioException catch (e) {
      // Error handling
      print(e);
      return null;
    }
  }
}