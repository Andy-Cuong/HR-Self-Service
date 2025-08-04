import 'package:dio/dio.dart';
import 'package:hr_self_service/src/data/services/dio_client.dart';
import 'package:hr_self_service/src/domain/data_source/remote_data_source.dart';
import 'package:hr_self_service/src/domain/models/personnel.dart';

class DioRemoteDataSource implements RemoteDataSource {
  final DioClient dioClient;

  DioRemoteDataSource(this.dioClient);

  @override
  Future<List<Personnel>> fetchPersonnel() async {
    try {
      final response = await dioClient.dio.get(
        'https://reqres.in/api/personnel'
      );

      if (response.statusCode != 200) {
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
}