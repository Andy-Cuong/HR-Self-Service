import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_card.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_list_provider.dart';

class PersonnelListScreen extends ConsumerWidget {
  const PersonnelListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(personnelListViewModelProvider);
    final personnelListAsync = ref.watch(personnelStreamProvider);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Personnel List')
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
    );
  }
}