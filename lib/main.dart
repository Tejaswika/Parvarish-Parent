import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parent/route_test_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parent/services/local_storage_service.dart';
import 'package:parent/services/notification_service.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      // Replace with actual values

      options: const FirebaseOptions(
        apiKey: "AIzaSyAcypiXEDRZ3rsx78gspfxtuYpNRTPURg4",
        appId: "1:238970681958:web:69c6a3749087144b7b0ba7",
        messagingSenderId: "238970681958",
        projectId: "parvarish-e8a53",
        storageBucket: "parvarish-e8a53.appspot.com",
        authDomain: "parvarish-e8a53.firebaseapp.com",
      ),
    );
  } catch (error) {
    print(error);
  }
  LocalStorageService.init();
  NotificationService.init();
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
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(39, 28, 162, 1),
          onPrimary: Color.fromRGBO(39, 28, 162, 0.5),
          secondary: Color.fromRGBO(108, 96, 255, 1),
          onSecondary: Color.fromRGBO(139, 130, 255, 0.5),
          background: Color.fromRGBO(139, 130, 255, 1),
          onBackground: Color.fromRGBO(139, 130, 255, 0.7),
          surface: Color.fromRGBO(244, 198, 255, 1),
          onSurface: Color.fromRGBO(244, 198, 255, 0.5),
          error: Colors.red,
          onError: Colors.red,
        ),
      ),
      home: const RouteTestScreen(),
    );
  }
}
