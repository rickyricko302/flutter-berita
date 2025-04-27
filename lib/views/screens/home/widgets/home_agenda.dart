import 'package:flutter/material.dart';

class HomeAgenda extends StatelessWidget {
  const HomeAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Agenda Penting Terdekat',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.blue.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Image.network(
            "https://udb.ac.id/storage/app/uploads/public/679/c32/87e/679c3287eefbe252342338.jpg",
          ),
        ],
      ),
    );
  }
}
