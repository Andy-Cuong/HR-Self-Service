class QrScannerState {
  final String scannedData;
  final bool checkedIn;
  final bool loadingCheckIn;

  QrScannerState({
    this.scannedData = '',
    this.checkedIn = false,
    this.loadingCheckIn = false
  });

  QrScannerState copy({
    String? scannedData,
    bool? checkedIn,
    bool? loadingCheckIn
  }) => QrScannerState(
    scannedData: scannedData ?? this.scannedData,
    checkedIn: checkedIn ?? this.checkedIn,
    loadingCheckIn: loadingCheckIn ?? this.loadingCheckIn
  );
}