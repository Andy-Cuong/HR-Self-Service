import 'package:hr_self_service/src/domain/models/personnel.dart';

class PersonnelListState {
  final List<Personnel> personnelList;

  PersonnelListState({
    this.personnelList = const [],
  });

  PersonnelListState copy({
    List<Personnel>? personnelList
  }) {
    return PersonnelListState(
      personnelList: personnelList ?? this.personnelList
    );
  }
}