import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/providers/personnel_repository_provider.dart';
import 'package:hr_self_service/src/domain/models/personnel.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_list_state.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_list_viewmodel.dart';

final personnelListViewModelProvider = StateNotifierProvider<PersonnelListViewmodel, PersonnelListState>(
  (ref) => PersonnelListViewmodel(ref),
);

// StreamProvider for personnel list
final personnelStreamProvider = StreamProvider<List<Personnel>>((ref) async* {
  final repoAsync = await ref.watch(personnelRepositoryProvider.future);
  yield* repoAsync.getAllPersonnel();
});