import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_card.dart';
import '../../providers/personnel_provider.dart';

class PersonnelListScreen extends ConsumerWidget {
    const PersonnelListScreen({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
    final personnelAsync = ref.watch(personnelProvider);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Personnel List')
        ),
        body: personnelAsync.when(
            data: (personnelList) => ListView.builder(
                itemCount: personnelList.length,
                itemBuilder: (context, index) {
                    final personnel = personnelList[index];
                    
                    return PersonnelCard(personnel: personnel);
                },
            ),
            error: (error, stack) => Center(child: Text('Error: $error')),
            loading: () => Center(child: CircularProgressIndicator())
        ),
    );
  }
}