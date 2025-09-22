import 'package:hr_self_service/src/ui/leave/leave_state.dart';

sealed class LeaveAction {}

class OnUpdatingFields extends LeaveAction {
  final LeaveType? newLeaveType;
  final DateTime? newStartDate;
  final DateTime? newEndDate;
  final String? newReason;
  final String? newContact;

  OnUpdatingFields({
    this.newLeaveType,
    this.newStartDate,
    this.newEndDate,
    this.newReason,
    this.newContact
  });
}

class OnSendClick extends LeaveAction {}