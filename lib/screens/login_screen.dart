import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:parent/screens/select_child.dart';
import 'package:parent/screens/SignUp_Screen.dart';
import 'package:parent/screens/forgot_password.dart';
import 'package:parent/services/local_storage_service.dart';
import 'package:parent/services/snackbar_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email, _password;
  final auth = FirebaseAuth.instance;
  bool _loginInProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 50),
            child: Text(
              'Welcome',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38, top: 90),
            child: Text(
              'Login to access your account',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 15),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(50, 150, 50, 10),
            height: 500,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 15,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email Address',
                        ),
                        onChanged: (value) {
                          setState(
                            () {
                              _email = value.trim();
                            },
                          );
                        },
                        validator:
                            ValidationBuilder().required().email().build(),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 15, right: 30),
                      child: TextFormField(
                        obscureText: true, //password stays hidden
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        onChanged: (value) {
                          setState(
                            () {
                              _password = value.trim();
                            },
                          );
                        },
                        validator: ValidationBuilder().required().build(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 30, top: 10),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Password(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            setState(() {
                              _loginInProcess = true;
                            });
                            _login();
                          }
                        },
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _loginInProcess
                            ? const Center(
                                child: SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          const Text(
                            'Do not have an account?',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    auth
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((UserCredential userCredential) {
      LocalStorageService.setData('UserId', userCredential.user?.uid ?? '');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SelectChild(uid: userCredential.user?.uid),
        ),
      );
    }).onError((error, stackTrace) async {
      setState(() {
        _loginInProcess = false;
      });
      if (error.toString().contains('no user')) {
        SnackbarService.showErrorSnackbar(context, 'User does not exists');
      } else if (error.toString().contains('password is invalid')) {
        SnackbarService.showErrorSnackbar(context, 'Invalid password');
      } else {
        SnackbarService.showErrorSnackbar(
            context, 'Some error occured!! Please try after some time.');
      }
    });
  }
}
