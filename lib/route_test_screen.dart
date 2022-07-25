// ignore_for_file: unused_import, duplicate_import, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:parent/screens/WelcomeScreen.dart';

class RouteTestScreen extends StatelessWidget {
  const RouteTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Route Test Screen', style: TextStyle(fontSize: 36)),
            const SizedBox(height: 20),

            // Welcome Screen...........

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Welcome Page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            // LOGIN PAGE ............
          ],
        ),
      ),
    );
  }
}
