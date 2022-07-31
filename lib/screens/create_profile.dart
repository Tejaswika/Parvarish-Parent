// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:parent/screens/select_child.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent/constants/db_constants.dart';

class ChildProfile extends StatefulWidget {
  final String? uid;
  const ChildProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  late String _uidChild;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Creating a reference to the collection
  late final CollectionReference _parentCollection =
      _firestore.collection(DBConstants.parentCollectionName);
  // To Update Document
  void _updateDocument(_uidChild, parentUID) async {
    // Creating a refrence(Anchor) to the document we want to access
    DocumentReference documentReferencer = _parentCollection.doc(parentUID);

    // Getting Snapshot from document reference created
    DocumentSnapshot parentDataSnapshot = await documentReferencer.get();

    // Getting data from Snapshot
    Map<String, dynamic>? parentData = parentDataSnapshot.data();

    // Getting children array from document
    List children = parentData?['children'];

    // Adding another child id to already existing children array from document
    children.add(_uidChild);

    Map<String, dynamic> data = <String, dynamic>{
      "children": children,
    };

    // Updating the document
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Child Added"))
        .catchError((e) => print(e));
  }

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
                    'Add Child Unique ID',
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
                      padding: const EdgeInsets.all(30),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter UID',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _uidChild = value.trim();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                                  builder: (context) =>
                                      SelectChild(uid: widget.uid)));
                          _updateDocument(_uidChild, widget.uid);
                        },
                        color: const Color.fromARGB(255, 116, 49, 128),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Save Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ]),
                )),
              )
            ],
          )),
    );
  }
}
