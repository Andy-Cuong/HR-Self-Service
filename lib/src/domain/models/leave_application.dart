class LeaveApplication {
  final String? id;
  final int personnelId;
  final String leaveType;
  final int startDateEpochMillis;
  final int endDateEpochMillis;
  final int numberOfDays;
  final String reason;
  final String contact;

  LeaveApplication({
    this.id,
    required this.personnelId,
    required this.leaveType,
    required this.startDateEpochMillis,
    required this.endDateEpochMillis,
    required this.numberOfDays,
    required this.reason,
    required this.contact,
  });

  factory LeaveApplication.fromJson(Map<String, dynamic> json) {
    return LeaveApplication(
      id: json['id'] as String?,
      personnelId: json['personnelId'] as int,
      leaveType: json['leaveType'] as String,
      startDateEpochMillis: json['startDateEpochMillis'] as int,
      endDateEpochMillis: json['endDateEpochMillis'] as int,
      numberOfDays: json['numberOfDays'] as int,
      reason: json['reason'] as String,
      contact: json['contact'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'leaveType' : leaveType,
      'personnelId' : personnelId,
      'startDateEpochMillis' : startDateEpochMillis,
      'endDateEpochMillis' : endDateEpochMillis,
      'numberOfDays' : numberOfDays,
      'reason' : reason,
      'contact' : contact
    };
    if (id != null) {
      json['id'] = id;
    }

    return json;
  }
}
