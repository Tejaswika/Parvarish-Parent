import 'package:flutter/material.dart';
import 'package:parent/screens/signup_screen.dart';
import 'package:parent/screens/login_screen.dart';
import 'package:parent/screens/otp.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 122, 220),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 50),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 38, top: 90),
              child: const Text(
                'Enter your email address',
                style: TextStyle(color: Colors.white60, fontSize: 15),
              )),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(50, 150, 50, 10),
            height: 600,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 163, 81, 180),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Otp()));
                      },
                      color: const Color.fromARGB(255, 116, 49, 128),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    //giave space between 2 boxes
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, top: 0),
                    child: Row(
                      children: [
                        const Text(
                          'Have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        const Text(
                          'Do not have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
