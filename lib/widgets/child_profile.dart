import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent/constants/db_constants.dart';
import '../services/local_storage_service.dart';

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
    DocumentReference documentReferencer = _childCollection.doc(widget.childId);
    DocumentSnapshot childDataSnapshot = await documentReferencer.get();
    _childData = childDataSnapshot.data() as Map<String, dynamic>;

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _readDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container()
        : InkWell(
            onTap: () {
              LocalStorageService.setFmcToken(
                  "fmcToken", _childData?["fmcToken"]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const MyNavPill()),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0XFF25C997),
                    ),
                    child: Center(
                      child: Text(
                        '${_childData?["name"]}'.substring(0, 1),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _childData?["name"] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Class: ${_childData?["class"]}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFC7C7C7),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.navigate_next,
                    size: 32,
                    color: Color(0xFFC7C7C7),
                  )
                ],
              ),
            ),
          );
  }
}
