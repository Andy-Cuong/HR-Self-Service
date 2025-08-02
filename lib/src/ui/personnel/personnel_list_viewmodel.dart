import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_list_state.dart';

class PersonnelListViewmodel extends StateNotifier<PersonnelListState> {
  final Ref ref;

  PersonnelListViewmodel(this.ref) : super(PersonnelListState());

}