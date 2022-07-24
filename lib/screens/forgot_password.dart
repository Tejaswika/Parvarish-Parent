// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:parent/screens/otp.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
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
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )),
              Container(
                  padding: EdgeInsets.only(left: 38, top: 90),
                  child: Text(
                    'Enter your email address',
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
                    SizedBox(
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
                                    builder: (context) => Otp()));
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
                    SizedBox(
                      //giave space between 2 boxes
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30,top: 0),
                      child: Row(
                        children: [
                          Container(
                              child: Text(
                            'Have an account?',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'login_screen');
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              )),
                          
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Container(
                              child: Text(
                            'Do not have an account?',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'SignUp_Screen');
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 16, color: Colors.white),
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