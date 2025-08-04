import 'package:flutter/material.dart';
import '../../domain/models/personnel.dart';

class PersonnelCard extends StatelessWidget {
  final Personnel personnel;

  const PersonnelCard({super.key, required this.personnel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              personnel.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            Text(
              personnel.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]) // Opacity?
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.email, size: 18, color: Colors.blueGrey,),
                const SizedBox(width: 8),
                Text(personnel.email),
              ],
            ),
            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(Icons.phone, size: 18, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(personnel.phoneNumber),
              ],
            )
          ],
        ),
      ),
    );
  }
}