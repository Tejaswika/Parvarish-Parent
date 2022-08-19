import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/db_constants.dart';
import '../services/snackbar_service.dart';

class ChildProfileUpdate extends StatefulWidget {
  final Map<String, dynamic>? childData;
  final String? childId;
  const ChildProfileUpdate(
      {Key? key, required this.childData, required this.childId})
      : super(key: key);

  @override
  State<ChildProfileUpdate> createState() => _ChildProfileUpdateState();
}

class _ChildProfileUpdateState extends State<ChildProfileUpdate> {
  final _formKey = GlobalKey<FormState>();
  bool isUpdatingDocument = false;
  bool isEditable = false;
  late String _email;
  late String _phoneNo;
  late String _name;
  late String _class;
  late String _age;
  late String? childName = widget.childData!["name"];
  late String? childEmail = widget.childData!["email"];
  late String? childPhone = widget.childData!["phone"];
  late String? childClass = widget.childData!["class"];
  late String? childAge = widget.childData!["age"];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference childCollection =
      _firestore.collection(DBConstants.childCollectionName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Personal Details",
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                'Child Profile Update',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 40),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              // alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                onChanged: (newValue) {
                  setState(() {
                    _name = newValue;
                  });
                },
                validator: (value) {
                  if (value == null && value == "") {
                    return "PLease enter a value";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabled: isEditable,
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                  hintText: childName,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                validator: (value) {
                  if (value == null && value == "") {
                    return "PLease enter a value";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _email = newValue;
                  });
                },
                decoration: InputDecoration(
                  enabled: isEditable,
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                  hintText: childEmail,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                validator: (value) {
                  if (value == null && value == "") {
                    return "PLease enter a value";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _phoneNo = newValue;
                  });
                },
                decoration: InputDecoration(
                  enabled: isEditable,
                  prefixIcon: const Icon(Icons.phone, color: Colors.white),
                  hintText: childPhone,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 50),

              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                validator: (value) {
                  if (value == null && value == "") {
                    return "PLease enter a value";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _age = newValue;
                  });
                },
                decoration: InputDecoration(
                  enabled: isEditable,
                  prefixIcon: const Icon(
                    Icons.edit_calendar_sharp,
                    color: Colors.white,
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                  hintText: childAge,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                validator: (value) {
                  if (value == null && value == "") {
                    return "PLease enter a value";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _class = newValue;
                  });
                },
                decoration: InputDecoration(
                  enabled: isEditable,
                  prefixIcon: const Icon(
                    Icons.class_rounded,
                    color: Colors.white,
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                  hintText: childClass,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                if (isEditable == false) {
                  setState(() {
                    isEditable = true;
                  });
                } else {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isUpdatingDocument = true;
                    });
                    updateChildData();
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 80, right: 80, top: 16, bottom: 16),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 9, 9, 9),
                    borderRadius: BorderRadius.circular(30)),
                child: isEditable
                    ? isUpdatingDocument
                        ? const Center(
                            child: SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : const Text(
                            'Update Profile',
                            style: TextStyle(
                                color: Color.fromARGB(255, 233, 231, 231)),
                          )
                    : const Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Color.fromARGB(255, 233, 231, 231)),
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void updateChildData() async {
    // print(widget.parentData);
    // isUpdatingDocument = true;
    DocumentReference documentReferencer = childCollection.doc(widget.childId);
    widget.childData?["name"] = _name;
    widget.childData?["email"] = _email;
    widget.childData?["phone"] = _phoneNo;
    widget.childData?["class"] = _class;
    widget.childData?["age"] = _age;
    // print(widget.childData);
    await documentReferencer.set(widget.childData).then((value) {
      setState(() {
        isUpdatingDocument = false;
      });
      SnackbarService.showSuccessSnackbar(
          context, "Profile updated successfully");
    });
  }
}
