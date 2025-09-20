import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hr_self_service/src/ui/qr_scanner/qr_scanner_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends ConsumerStatefulWidget {
  const QRScannerScreen({super.key});

  @override
  ConsumerState<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends ConsumerState<QRScannerScreen> {
  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    ref.listen(qrScannerViewModelProvider, (previous, next) {
      if (previous != null && previous.loadingCheckIn && !next.loadingCheckIn && !next.checkedIn) { // Check-in failed
        Fluttertoast.showToast(
          msg: 'Check-in failed. Please try again.',
          toastLength: Toast.LENGTH_SHORT
        );
      }

      if (!next.loadingCheckIn && next.checkedIn) { // Check-in successful
        Fluttertoast.showToast(
          msg: 'Check-in successful.',
          toastLength: Toast.LENGTH_SHORT
        );
        Navigator.of(context).pop(); // Navigate back if successful
      }
    });

    final state = ref.watch(qrScannerViewModelProvider);
    final viewModel = ref.read(qrScannerViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code to Check In')),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: state.loadingCheckIn,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: MobileScanner(
                    controller: controller,
                    onDetect: (result) {
                      controller.pause();
            
                      final scannedData = result.barcodes.first.displayValue!;
                      viewModel.checkInPersonnel(0, scannedData);
                      print(scannedData);
                    },
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text('Scan to check in\n${state.scannedData}'),
                  )
                ),
              ],
            ),
          ),

          if (state.loadingCheckIn)
            Container(
              color: Colors.black38,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ]
      ),
    );
  }
}