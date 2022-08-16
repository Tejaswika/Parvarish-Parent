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
     int _selected=0;
    void changeSelected(int index){
      setState(() {
        _selected=index;
      });
    }
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
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Select Child',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: Container(
        color: Colors.white,
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text(
                  "Tarushi",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ), 
                accountEmail: Text("test@gmail.com",
                style: TextStyle(
                    fontSize: 15,
                  ),
                  ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white30,
                  child: Text("TS"),
                  ),
                ),
                ListTile(
                  selected: _selected==0,
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    changeSelected(0);
                  } ,
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),

                ListTile(
                  selected: _selected==1,
                  leading: const Icon(Icons.face),
                  title: const Text("My Profile"),
                  onTap: () {
                    changeSelected(1);
                  } ,
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),

                ListTile(
                  selected: _selected==3,
                  leading: const Icon(Icons.book),
                  title: const Text("Report"),
                  onTap: () {
                    changeSelected(3);
                  } ,
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                ListTile(
                  selected: _selected==2,
                  leading: const Icon(Icons.quiz),
                  title: const Text("Quiz"),
                  onTap: () {
                    changeSelected(2);
                  } ,
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),


                ListTile(
                  selected: _selected==4,
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    changeSelected(4);
                  } ,
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ), 

                // ListTile(
                //   selected: _selected==5,
                //   leading: const Icon(Icons.home),
                //   title: const Text("home"),
                //   onTap: () {
                //     changeSelected(5);
                //   } ,
                //   trailing: const Icon(Icons.arrow_forward_ios_rounded),
                // ),
                // const Divider(
                //   thickness: 1,
                //   indent: 10,
                //   endIndent: 10,
                // ),

                const ListTile(),
                const ListTile(),
                ListTile(
                  selected: _selected==6,
                  leading: const Icon(Icons.phone),
                  title: const Text("Contact Us"),
                  onTap: () {
                    changeSelected(6);
                  } ,
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),

                ListTile(
                  selected: _selected==7,
                  leading: const Icon(Icons.logout_sharp),
                  title: const Text("Logout"),
                  onTap: () {
                    changeSelected(7);
                  } ,
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                
            ],
          ),
        )
        ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : parentData?["children"].length == 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: _createAddChildButton(context),
                )
              : ListView.builder(
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
    );
  }

  Widget _createAddChildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => CreateProfile(
                  uid: widget.uid,
                  successCallback: () {
                    setState(() {
                      _loading = true;
                    });
                    readParentData();
                  },
                )),
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
