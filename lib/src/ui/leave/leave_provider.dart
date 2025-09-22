import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/ui/leave/leave_state.dart';
import 'package:hr_self_service/src/ui/leave/leave_viewmodel.dart';

final leaveViewModelProvider = NotifierProvider<LeaveViewModel, LeaveState>(
  LeaveViewModel.new
);