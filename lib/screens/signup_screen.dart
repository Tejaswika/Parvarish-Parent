import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:parent/screens/select_child.dart';
import 'package:parent/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent/constants/db_constants.dart';
import 'package:parent/services/local_storage_service.dart';
import 'package:parent/services/snackbar_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  late String _email, _password, _name, _phone;
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProcess = false;
  late final CollectionReference _parentCollection =
      _firestore.collection(DBConstants.parentCollectionName);
  late String? fmcToken;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        fmcToken = token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 50),
              child: Text(
                'Sign up',
                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                'Create your account',
                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(50, 30, 50, 10),
              height: 500,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, top: 30, right: 30),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _name = value.trim();
                          });
                        },
                        validator: ValidationBuilder().required().build(),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, top: 30, right: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email Address',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          });
                        },
                        validator:
                            ValidationBuilder().required().email().build(),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, top: 30, right: 30),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Phone No.',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _phone = value.trim();
                          });
                        },
                        validator:
                            ValidationBuilder().required().phone().build(),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, top: 30, right: 30),
                      child: TextFormField(
                        obscureText: true, //password stays hidden
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _password = value.trim();
                          });
                        },
                        validator:
                            ValidationBuilder().required().minLength(8).build(),
                      ),
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
                              _signUpInProcess = true;
                            });
                            _signUp();
                          }
                        },
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _signUpInProcess
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child:  Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 16, color:Theme.of(context).colorScheme.onPrimary,),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _signUp() {
    auth
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((UserCredential userCredential) {
      LocalStorageService.setUid('UserId', userCredential.user?.uid ?? '');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SelectChild(uid: userCredential.user?.uid),
        ),
      );
      _createProfile(userCredential.user?.uid, _name, _email, _phone);
    }).onError((error, stackTrace) {
      setState(() {
        _signUpInProcess = false;
      });
      if (error.toString().contains('email address is already in use')) {
        SnackbarService.showErrorSnackbar(context, 'User already exists');
      } else {
        SnackbarService.showErrorSnackbar(
            context, 'Some error occured!! Please try after some time.');
      }
    });
  }

  void _createProfile(uid, name, email, phone) async {
    DocumentReference documentReferencer = _parentCollection.doc(uid);

    Map<String, dynamic> data = <String, dynamic>{
      "children": [],
      "email": email,
      "name": name,
      "phone": phone,
      "fmcToken": fmcToken,
    };

    await documentReferencer.set(data).onError((error, stackTrace) {
      setState(() {
        _signUpInProcess = false;
      });
      SnackbarService.showErrorSnackbar(
          context, 'Some error occured!! Please try after some time.');
    });
  }
}
