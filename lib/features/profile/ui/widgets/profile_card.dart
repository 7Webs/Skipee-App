import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFECEEED),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey)),
            const SizedBox(width: 100),
            Text(value,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
