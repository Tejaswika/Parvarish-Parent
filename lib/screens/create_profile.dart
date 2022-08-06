import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent/constants/db_constants.dart';

class CreateProfile extends StatefulWidget {
  final String? uid;
  const CreateProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  late String _uidChild;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Creating a reference to the collection
  late final CollectionReference _parentCollection =
      _firestore.collection(DBConstants.parentCollectionName);
  // To Update Document

  // void _showMessage(BuildContext context) {
  //   final scaffold = Scaffold.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: const Text('Child already existsUpdating..'),
  //     ),
  //   );
  // }

  bool _isDuplicate = false;
  bool _loading = true;
  bool _isChildAdded = false;

  void _updateDocument(_uidChild, parentUID) async {
    // Creating a refrence(Anchor) to the document we want to access
    DocumentReference documentReferencer = _parentCollection.doc(parentUID);

    // Getting Snapshot from document reference created
    DocumentSnapshot parentDataSnapshot = await documentReferencer.get();

    // Getting data from Snapshot
    Map<String, dynamic>? parentData =
        parentDataSnapshot.data() as Map<String, dynamic>;

    // Getting children array from document
    List children = parentData['children'];
    for (int i = 0; i < children.length; i++) {
      print(children[i]);
      if (children[i] == _uidChild) {
        _isDuplicate = true;
        print("Child already present");
        break;
      }
    }
    if (!_isDuplicate) {
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
    _isChildAdded = true;
    setState(() {
      _loading = false;
    });
  }

  then() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 122, 220),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 50),
            child: const Text(
              'Add Child Unique ID',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(50, 150, 50, 10),
            height: 600,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 163, 81, 180),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                        print(_uidChild);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        if (_loading) const CircularProgressIndicator();
                        if (!_isChildAdded) {
                          _updateDocument(_uidChild, widget.uid);
                        }
                        print(_isDuplicate);
                        if (_isDuplicate) {
                          print("Hello");
                          final scaffold = ScaffoldMessengerState();
                          scaffold.showSnackBar(
                            const SnackBar(
                              content: Text('Child already existsUpdating..'),
                            ),
                          );
                        }
                        Navigator.pop(context);
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
