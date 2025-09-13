import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_card.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_list_provider.dart';
import 'package:hr_self_service/src/ui/qr_scanner/qr_scanner_screen.dart';
import 'package:hr_self_service/src/ui/settings/setting_screen.dart';

class PersonnelListScreen extends ConsumerWidget {
  const PersonnelListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(personnelListViewModelProvider);
    final personnelListAsync = ref.watch(personnelStreamProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Personnel List'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SettingScreen())
                );
              },
              icon: Icon(Icons.settings)
            ),
          ],
      ),
      body: personnelListAsync.when(
        data: (personnelList) => 
          ListView.builder(
            itemCount: personnelList.length,
            itemBuilder: (context, index) {
              final personnel = personnelList[index];
              
              return PersonnelCard(personnel: personnel);
            },
          ),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator())
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => QRScannerScreen())
          );
        },
        child: Icon(Icons.qr_code_2)
      ),
    );
  }
}