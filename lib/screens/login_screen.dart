// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:parent/screens/SelectChild.dart';
import 'package:parent/screens/SignUp_Screen.dart';
import 'package:parent/screens/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 205, 122, 220),
          body: Stack(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 35, top: 50),
                  child: Text(
                    'Welcome',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )),
              Container(
                  padding: EdgeInsets.only(left: 38, top: 90),
                  child: Text(
                    'Login to access your account',
                    style: TextStyle(color: Colors.white60, fontSize: 15),
                  )),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(50, 150, 50, 10),
                height: 600,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 163, 81, 180),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                    child: Container(
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                      child: TextField(
                        obscureText: true, //password stays hidden
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 25, right: 30, top: 10),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Password()));
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                        ),
                      ],
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
                                  builder: (context) => SelectChild()));
                        },
                        color: const Color.fromARGB(255, 116, 49, 128),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      //giave space between 2 boxes
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Container(
                              child: Text(
                            'Do not have an account?',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                        ],
                      ),
                    )
                  ]),
                )),
              )
            ],
          )),
    );
  }
}
