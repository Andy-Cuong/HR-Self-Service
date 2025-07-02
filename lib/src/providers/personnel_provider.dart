import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/personnel.dart';

final personnelProvider = FutureProvider<List<Personnel>>((ref) async {
  return await PersonnelModel.loadPersonnelFromJson();
});