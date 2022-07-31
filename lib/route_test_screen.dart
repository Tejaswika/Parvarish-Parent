// ignore_for_file: unused_import, duplicate_import, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parent/constants/db_constants.dart';

import 'package:parent/screens/welcome_screen.dart';

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
            const Text('Route Test Screen', style: TextStyle(fontSize: 36)),
            const SizedBox(height: 20),

            // Welcome Screen...........

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
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
          ],
        ),
      ),
    );
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
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  // To Update Document
  void _updateDocument() async {
    // Creating a refrence(Anchor) to the document we want to access
    DocumentReference documentReferencer = _parentCollection.doc('uid-xxx2');

    // Getting Snapshot from document reference created
    DocumentSnapshot parentDataSnapshot = await documentReferencer.get();

    // Getting data from Snapshot
    Map<String, dynamic>? parentData = parentDataSnapshot.data();

    // Getting children array from document
    List children = parentData?['children'];

    // Adding another child id to already existing children array from document
    children.add('id_3');

    Map<String, dynamic> data = <String, dynamic>{
      "children": children,
    };

    // Updating the document
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  // TO read Document
  void _readDocument() async {
    // Creating a refrence(Anchor) to the document we want to access
    DocumentReference documentReferencer = _parentCollection.doc('uid-xxx2');

    // Getting Snapshot from document reference created
    DocumentSnapshot parentDataSnapshot = await documentReferencer
        .get()
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));

    // Getting data from Snapshot
    Map<String, dynamic>? parentData = parentDataSnapshot.data();
  }
}
