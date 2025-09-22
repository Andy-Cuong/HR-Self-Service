import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/providers/personnel_repository_provider.dart';
import 'package:hr_self_service/src/domain/repository/personnel_repository.dart';
import 'package:hr_self_service/src/ui/leave/leave_action.dart';
import 'package:hr_self_service/src/ui/leave/leave_state.dart';

class LeaveViewModel extends Notifier<LeaveState> {
  late final PersonnelRepository _personnelRepository;

  @override
  LeaveState build() {
    ref.watch(personnelRepositoryProvider).when(
      data: (data) {
        _personnelRepository = data;
      },
      error: (error, stack) {
        print('Error: $error\nStack trace: $stack');
      },
      loading: () {}
    );
    
    return LeaveState();
  }

  void onAction(LeaveAction action) {
    switch (action) {
      case OnUpdatingFields():
        _updateFields(action);
      case OnSendClick():
        _sendLeaveApplication(action);
    }
  }

  void _updateFields(OnUpdatingFields action) {
    state = state.copy(
      leaveType: action.newLeaveType,
      startDate: action.newStartDate,
      endDate: action.newEndDate,
      reason: action.newReason,
      contact: action.newContact
    );

    state = state.copy(
      numberOfDays: state.endDate.difference(state.startDate).inDays + 1
    );
  }
  
  void _sendLeaveApplication(OnSendClick action) async {
    state = state.copy(loading: true);

    final applicationId = await _personnelRepository.sendLeaveApplication(state.toLeaveApplication());

    if (applicationId != null) {
      state = state.copy(
        applicationSent: true
      );
    }

    state = state.copy(
      loading: false
    );

    state = LeaveState();
  }
}