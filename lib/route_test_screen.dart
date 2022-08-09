import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:parent/constants/db_constants.dart';
import 'package:parent/screens/quiz.dart';
=======
>>>>>>> 94ac24b9549346480adaacfb96c0622378bd0265

import 'package:parent/constants/db_constants.dart';
import 'package:parent/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;

class RouteTestScreen extends StatefulWidget {
  const RouteTestScreen({Key? key}) : super(key: key);

  @override
  State<RouteTestScreen> createState() => _RouteTestScreenState();
}

class _RouteTestScreenState extends State<RouteTestScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Creating a reference to the collection
  late final CollectionReference _parentCollection =
      _firestore.collection(DBConstants.parentCollectionName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Route Test Screen',
              style: TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 20),

            // Welcome Screen...........

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Welcome Page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  _createDocument();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Create Query',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  _readDocument();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Read Query',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizReport(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Quiz Report',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  _updateDocument();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Update query',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  sendPushMessage();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red,
                  child: const Text(
                    'Send Notification',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAN6PDOmY:APA91bFQ9RmZ9z6t2uwqy695724nwjnm5XPdTmygjL1R54T4AHdIQJAhRKteK4agmEfY87pTNYV22v9DPc__GMObXdvbR_8SHsL_6o_ec8ohyU9XwJ_Dh9xgm3LP2S_1VGB3k4QiQIWe',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'This is notification body',
              'title': 'Title',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to":
                'c50Jx24ZQi-QxyIPZovxpM:APA91bHDUKQghJ_P6CHV2K0NsViZS8D-clKVOD0O-444eHuYXaJdF7fawJRh9dR0WGlbIbmUlHAP8TSDc7I2cTr25bY6RtAciT7svNm4AyJ0PneJkdJ7xiLFbfLCT49SMpWPFO4xdv4n',
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  // TO Create Document
  void _createDocument() async {
    // Creating a document to Store Data To
    DocumentReference documentReferencer = _parentCollection.doc('uid-xxx2');

    // Creating data to be stored
    Map<String, dynamic> data = <String, dynamic>{
      "title": 'title',
      "description": 'description',
      "children": []
    };

    // Pushing data to the document
    await documentReferencer.set(data);
  }

  // To Update Document
  void _updateDocument() async {
    // Creating a refrence(Anchor) to the document we want to access
    DocumentReference documentReferencer = _parentCollection.doc('uid-xxx2');

    // Getting Snapshot from document reference created
    DocumentSnapshot parentDataSnapshot = await documentReferencer.get();

    // Getting data from Snapshot
    Map<String, dynamic>? parentData =
        parentDataSnapshot.data() as Map<String, dynamic>;

    // Getting children array from document
    List children = parentData['children'];

    // Adding another child id to already existing children array from document
    children.add('id_3');

    Map<String, dynamic> data = <String, dynamic>{
      "children": children,
    };

    // Updating the document
    await documentReferencer.update(data);
  }

  // TO read Document
  void _readDocument() async {
    // Creating a refrence(Anchor) to the document we want to access
    DocumentReference documentReferencer = _parentCollection.doc('uid-xxx2');

    // Getting Snapshot from document reference created
    DocumentSnapshot parentDataSnapshot = await documentReferencer.get();

    // Getting data from Snapshot
    Map<String, dynamic>? parentData =
        parentDataSnapshot.data() as Map<String, dynamic>;
    print(parentData);
  }
}
