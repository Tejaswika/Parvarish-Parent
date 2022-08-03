import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:parent/constants/db_constants.dart';
import 'package:parent/screens/create_profile.dart';
import 'package:parent/widgets/child_profile.dart';

class SelectChild extends StatefulWidget {
  final String? uid;
  const SelectChild({Key? key, required this.uid}) : super(key: key);

  @override
  _SelectChildState createState() => _SelectChildState();
}

class _SelectChildState extends State<SelectChild> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference _parentCollection =
      _firestore.collection(DBConstants.parentCollectionName);
  Map<String, dynamic>? parentData;
  @override
  void initState() {
    // TODO: implement initState
    // readParentData();
    super.initState();
  }

  Future readParentData() async {
    DocumentReference documentReferencer = _parentCollection.doc(widget.uid);
    DocumentSnapshot parentDataSnapshot = await documentReferencer
        .get()
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));

    // Getting data from Snapshot
    parentData = parentDataSnapshot.data() as Map<String, dynamic>;
    print(parentData);
  }

  void despose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(parentData?["name"] ?? "Error"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Select Child",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: parentData?["children"].length,
                itemBuilder: (context, index) => Container(),
                // ChildProfile(childId: parentData?["children"][index]),
              ),
              MaterialButton(
                shape: const CircleBorder(side: BorderSide(width: 10)),
                child: const Text("Add child"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateProfile(uid: widget.uid),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
