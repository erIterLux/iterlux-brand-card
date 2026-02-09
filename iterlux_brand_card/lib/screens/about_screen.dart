import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset('assets/images/iterluxwhite.svg', height: 120, width: 120),
            ),
            const Text('Iterlux Inc.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text(
              'Iterlux is dedicated to empowering small businesses with big aspirations...',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {}, // Add URL launcher if needed
              child: const Text('Visit Our Website'),
            ),
          ],
        ),
      ),
    );
  }
}