import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final state = ref.watch(qrScannerViewModelProvider);
    final viewModel = ref.read(qrScannerViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code to Check In')),
      body: Stack(
        children: [
          Column(
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

                    if (state.checkedIn) {
                      Navigator.of(context).pop(); // Navigate back if successful
                    } else {
                      controller.start(); // Restart the camera otherwise
                    }
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