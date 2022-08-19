import 'package:flutter/material.dart';
import 'package:parent/screens/login_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late String _oldPass;
  late String _newPass;
  late String _confirmPass;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Personal Details",
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                'Change Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 40),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              // alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                onChanged: (newValue) {
                  setState(() {
                    _oldPass = newValue;
                  });
                },
                validator: (value) {
                  if (value == null && value == "") {
                    return "PLease enter a value";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key, color: Colors.white),
                  hintText: "Enter Old Password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                validator: (value) {
                  if (value == null && value == "") {
                    return "PLease enter a value";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _newPass = newValue;
                  });
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.white),
                  hintText: "Enter new password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                validator: (value) {
                  if (value == null && value == "") {
                    return "PLease enter a value";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _confirmPass = newValue;
                  });
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.white),
                  hintText: "Re-Enter new password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 80, right: 80, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 9, 9, 9),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: Color.fromARGB(255, 233, 231, 231)),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
