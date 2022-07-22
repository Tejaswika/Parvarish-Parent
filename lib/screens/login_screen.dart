// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:parent/screens/SignUp_Screen.dart';

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
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 163, 81, 180),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      right: 35,
                      left: 35,
                      bottom: MediaQuery.of(context).size.height * 0.01),
                  child: Column(children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      //giave space between 2 boxes
                      height: 30,
                    ),
                    TextField(
                      obscureText: true, //password stays hidden
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15,
                                  color: Colors.white),
                            ))
                      ],
                    ),
                    SizedBox(
                      //giave space between 2 boxes
                      height: 30,
                    ),

                    /*Row(
                      children: [
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, 'register');
                      }, 
                      child: Text('Login', style: TextStyle(
                        fontSize:18,
                        color: Colors.white
                      ),))
                    ],),
                    
*/
                    Container(
                      height: 50,
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 49, 128),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      //giave space between 2 boxes
                      height: 40,
                    ),
                    Row(
                      children: [
                        Container(
                            child: Text(
                          'Do not have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ))
                      ],
                    )
                  ]),
                )),
              )

            ],
          )),
    );
  }
}

