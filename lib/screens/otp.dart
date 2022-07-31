// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:parent/screens/create_new_password.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
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
                    'Enter the one time password',
                    style: TextStyle(color: Colors.white, fontSize: 30),
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
                      padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                      child: TextField(
                        //obscureText: true, //password stays hidden
                        decoration: InputDecoration(
                          hintText: 'OTP',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 23, top: 10),
                      alignment: Alignment.centerLeft,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Otp()));
                        },
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                                  builder: (context) => NewPassword()));
                        },
                        color: const Color.fromARGB(255, 116, 49, 128),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      //giave space between 2 boxes
                      height: 40,
                    ),
                  ]),
                )),
              )
            ],
          )),
    );
  }
}
