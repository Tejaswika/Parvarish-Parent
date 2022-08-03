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
  bool _loading = true;

  @override
  void initState() {
    readParentData();
    super.initState();
  }

  Future readParentData() async {
    DocumentReference documentReferencer = _parentCollection.doc(widget.uid);
    DocumentSnapshot parentDataSnapshot = await documentReferencer.get();

    parentData = parentDataSnapshot.data() as Map<String, dynamic>;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        title: const Text('Select Child'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: parentData?["children"].length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index == 0) const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 6),
                              child: ChildProfile(
                                  childId: parentData?["children"][index]),
                            ),
                            if (index == parentData?["children"].length - 1)
                              _createAddChildButton(context)
                          ],
                        );
                      }),
                ),
              ],
            ),
    );
  }

  Widget _createAddChildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => CreateProfile(uid: widget.uid)),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Add Child',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFC7C7C7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
