import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/ui/qr_scanner/qr_scanner_state.dart';
import 'package:hr_self_service/src/ui/qr_scanner/qr_scanner_viewmodel.dart';

final qrScannerViewModelProvider = NotifierProvider<QrScannerViewmodel, QrScannerState>(
  QrScannerViewmodel.new
);