import 'package:flutter/material.dart';
import 'package:parent/screens/MyNavPill.dart';
import 'package:parent/screens/SignUp_Screen.dart';
import 'package:parent/screens/WelcomeScreen.dart';
import 'package:parent/screens/app_timer.dart';
import 'package:parent/screens/login_screen.dart';
import 'package:parent/screens/childScreen.dart';

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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Login Page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            // No. Of child Page.

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChildPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'No. of child page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            // SIGNUP PAGE.......

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'SignUp Page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            // Graph Page ............

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyNavPill(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Graph Page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // App timer
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Apptimer(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'App timer page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
