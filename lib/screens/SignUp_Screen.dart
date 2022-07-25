import 'package:flutter/material.dart';
import 'package:parent/screens/SelectChild.dart';
import 'package:parent/screens/login_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 156, 61, 239),
        body: Stack(
          children: [
            Positioned(
              top: 130,
              left: 56,
              child: Container(
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 56,
              child: Container(
                child: const Text(
                  "Create my account",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 7,
              child: Container(
                margin: const EdgeInsets.only(left: 48, top: 30),
                height: 400,
                width: 255,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 228, 244),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "Parent's Name",
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "Email Address",
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectChild()));
                          },
                          color: const Color.fromARGB(255, 156, 61, 239),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: const Text("Login"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
