import 'package:flutter/material.dart';
import 'package:parent/route_test_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values

    options: FirebaseOptions(
      apiKey: "AIzaSyAcypiXEDRZ3rsx78gspfxtuYpNRTPURg4",
      appId: "1:238970681958:web:69c6a3749087144b7b0ba7",
      messagingSenderId: "238970681958",
      projectId: "parvarish-e8a53",
      storageBucket: "parvarish-e8a53.appspot.com",
      authDomain: "parvarish-e8a53.firebaseapp.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RouteTestScreen(),
    );
  }
}
