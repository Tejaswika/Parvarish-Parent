import 'package:flutter/material.dart';
import 'package:parent/screens/login_screen.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 122, 220),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 35, top: 50),
              child: const Text(
                'Create new Password',
                style: TextStyle(color: Colors.white, fontSize: 30),
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
                        hintText: 'New password',
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, top: 30, right: 30),
                    child: const TextField(
                      obscureText: true, //password stays hidden
                      decoration: InputDecoration(
                        hintText: 'Re-enter new password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
                                builder: (context) => LoginPage()));
                      },
                      color: const Color.fromARGB(255, 116, 49, 128),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    //giave space between 2 boxes
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
