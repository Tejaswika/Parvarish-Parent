import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parent/screens/SelectChild.dart';
import 'package:parent/screens/login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 205, 122, 220),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 50),
              child: const Text(
                'Sign up',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 38, top: 90),
              child: const Text(
                'Create your account',
                style: TextStyle(color: Colors.white60, fontSize: 15),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(50, 150, 50, 10),
              height: 600,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 163, 81, 180),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email Address',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                  child: TextField(
                    obscureText: true, //password stays hidden
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () {
                      auth
                          .createUserWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((UserCredential userCredential) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                SelectChild(uid: userCredential.user?.uid),
                          ),
                        );
                      });
                    },
                    color: const Color.fromARGB(255, 116, 49, 128),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25),
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
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ],
                  ),
                )
              ])),
            )
          ],
        ));
  }
}


