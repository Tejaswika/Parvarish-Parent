import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parent/constants/db_constants.dart';
import 'package:parent/screens/my_nav_pill.dart';
import 'package:parent/screens/create_profile.dart';

class SelectChild extends StatefulWidget {
  final String? uid;
  const SelectChild({Key? key, required this.uid}) : super(key: key);

  @override
  _SelectChildState createState() => _SelectChildState();
}

class _SelectChildState extends State<SelectChild> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   @override
  void initState() {
    _getParentChildren();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getParentChildren();
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Child Profile'),
        ),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  runSpacing: 5.0,
                  spacing: 10.0,
                  children: [
                    Container(
                        child: RichText(
                      text: TextSpan(
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Select/Add Child \n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ],
                      ),
                    )),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/2922/2922561.png'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyNavPill()));
                                    },
                                    child: Text(
                                      'Neha Singh',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/2922/2922510.png'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyNavPill()));
                                    },
                                    child: Text(
                                      'Raj Kumar',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/1237/1237946.png'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChildProfile(
                                                      uid: widget.uid)));
                                    },
                                    child: Text(
                                      'Add Child',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }

  void _getParentChildren() async {
    final CollectionReference _parentCollection =
        _firestore.collection(DBConstants.parentCollectionName);
    DocumentReference documentReferencer = _parentCollection.doc(widget.uid);
    DocumentSnapshot parentDataSnapshot = await documentReferencer.get();
    Map<String, dynamic>? parentData = parentDataSnapshot.data();

    List<dynamic> children = parentData?['children'];

    List<Map<String, dynamic>?> childrenData = [];

    children.forEach((dynamic childId) async{
      DocumentSnapshot childDataSnapshot = await _getChildData(childId);
      Map<String, dynamic>? childData = childDataSnapshot.data();
      childrenData.add(childData);
      print(childData);
    });

    print(childrenData);
  }

  Future<DocumentSnapshot> _getChildData(String childId) async {
    final CollectionReference _childrenCollection =
        _firestore.collection(DBConstants.childCollectionName);
    DocumentReference documentReferencer = _childrenCollection.doc(childId);

    return documentReferencer.get();
  }
}
