import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent/constants/db_constants.dart';

import 'package:parent/constants/pics_constants.dart';
import 'package:parent/screens/my_nav_pill.dart';

class ChildProfile extends StatefulWidget {
  final String? childId;
  const ChildProfile({Key? key, this.childId}) : super(key: key);

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _childCollection =
      _firestore.collection(DBConstants.childCollectionName);
  Map<String, dynamic>? _childData;
  bool _loading = true;

  void _readDocument() async {
    // Creating a refrence(Anchor) to the document we want to access
    DocumentReference documentReferencer = _childCollection.doc(widget.childId);

    // Getting Snapshot from document reference created
    DocumentSnapshot childDataSnapshot = await documentReferencer
        .get()
        .whenComplete(() => print("Document retrived successfully"))
        .catchError((e) => print(e));

    // Getting data from Snapshot
    Map<String, dynamic>? _childData =
        childDataSnapshot.data() as Map<String, dynamic>;
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    _readDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => MyNavPill()),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 15),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(PicConstant.boyPic),
                  ),
                  Text(
                    _childData?["name"] ?? "Error",
                    style: const TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          );
  }
}
