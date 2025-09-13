import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hr_self_service/src/data/providers/personnel_repository_provider.dart';
import 'package:hr_self_service/src/domain/repository/personnel_repository.dart';
import 'package:hr_self_service/src/ui/qr_scanner/qr_scanner_state.dart';

class QrScannerViewmodel extends Notifier<QrScannerState> {
  late final PersonnelRepository _personnelRepository;

  @override
  QrScannerState build() {
    ref.watch(personnelRepositoryProvider).when(
      data: (data) {
        _personnelRepository = data;
      },
      error: (error, stack) {
        print('Error: $error');
        print('Stack trace: $stack');
      },
      loading: () {}
    );

    return QrScannerState();
  }

  Future<bool> checkInPersonnel(int id, String scannedData) async {
    state = state.copy(
      scannedData: scannedData,
      loadingCheckIn: true
    );

    try {
      final checkInSuccessful = await _personnelRepository.checkInPersonnel(id, scannedData);
      state = state.copy(
        scannedData: '',
        checkedIn: checkInSuccessful,
        loadingCheckIn: false
      );

      final toastMessage = checkInSuccessful? 'Check-in successful.' : 'Check-in failed. Please try again.';
      Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT
      );
      
      return checkInSuccessful;
    } catch (e) {
      print(e);
      state = state.copy(
        checkedIn: false,
        loadingCheckIn: false
      );

      return false;
    }
  }
}