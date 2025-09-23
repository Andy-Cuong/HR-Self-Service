import 'package:hr_self_service/src/domain/models/leave_application.dart';
import 'package:uuid/uuid.dart';

class LeaveState {
  final LeaveType leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfDays;
  final String reason;
  final String contact;
  final bool loading;
  final bool applicationSent;

  LeaveState({
    this.leaveType = LeaveType.unpaid,
    DateTime? startDate,
    DateTime? endDate,
    this.reason = '',
    this.contact = '',
    this.loading = false,
    this.applicationSent = false
  }) : startDate = startDate ?? DateTime.now(),
       endDate = endDate ?? DateTime.now(),
       numberOfDays = _differenceInDays(startDate, endDate);

  static int _differenceInDays(DateTime? startDate, DateTime? endDate) {
    final start = startDate ?? DateTime.now();
    final end = endDate ?? DateTime.now();

    if (end.isBefore(start)) {
      return 0;
    }

    return end.difference(start).inDays + 1;
  }

  LeaveState copy({
    LeaveType? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    String? reason,
    String? contact,
    bool? loading,
    bool? applicationSent
  }) {
    final newEndDate = endDate ?? this.endDate;
    final newStartDate = startDate ?? this.startDate;

    return LeaveState(
      leaveType: leaveType ?? this.leaveType,
      startDate: newStartDate,
      endDate: newEndDate,
      reason: reason ?? this.reason,
      contact: contact ?? this.contact,
      loading: loading ?? this.loading,
      applicationSent: applicationSent ?? this.applicationSent
    );
  }

  LeaveApplication toLeaveApplication() {
    return LeaveApplication(
      id: Uuid().v1(),
      personnelId: 1, // Load this personnel's ID
      leaveType: leaveType.name,
      startDateEpochMillis: startDate.millisecondsSinceEpoch,
      endDateEpochMillis: endDate.millisecondsSinceEpoch,
      numberOfDays: numberOfDays,
      reason: reason,
      contact: contact
    );
  }
}

enum LeaveType {
  annual,
  sick,
  unpaid
}