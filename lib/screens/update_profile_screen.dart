import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parent/services/snackbar_service.dart';
import '../constants/db_constants.dart';

class UpdateProfile extends StatefulWidget {
  final String? childId;
  final String? parentId;
  final Map<String, dynamic>? parentData;
  const UpdateProfile(
      {Key? key,
      required this.parentId,
      required this.childId,
      required this.parentData})
      : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  bool isUpdatingDocument = false;
  bool isEditable = false;
  late String _email;
  late String _phoneNo;
  late String _name;
  late String? parentName = widget.parentData!["name"];
  late String? parentEmail = widget.parentData!["email"];
  late String? parentPhone = widget.parentData!["phone"];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference parentCollection =
      _firestore.collection(DBConstants.parentCollectionName);
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
                'Profile Update',
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
                  hintText: parentName,
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
                  hintText: parentEmail,
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
                  hintText: parentPhone,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   alignment: Alignment.topLeft,
            //   margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),

            //   // ignore: prefer_const_constructors
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(30)),
            //   child: TextFormField(
            //     validator: (value) {
            //       if (value == null && value == "") {
            //         return "PLease enter a value";
            //       }
            //       return null;
            //     },
            //     decoration: InputDecoration(
            //       enabled: isEditable,
            //       prefixIcon: const Icon(Icons.calendar_view_day),
            //       hintText: 'Enter Your Age',
            //       border: InputBorder.none,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
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
                    updateParentData();
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

  void updateParentData() async {
    // print(widget.parentData);
    // isUpdatingDocument = true;
    DocumentReference documentReferencer =
        parentCollection.doc(widget.parentId);
    widget.parentData?["name"] = _name;
    widget.parentData?["email"] = _email;
    widget.parentData?["phone"] = _phoneNo;
    print(widget.parentData);
    await documentReferencer.set(widget.parentData).then((value) {
      setState(() {
        isUpdatingDocument = false;
      });
      SnackbarService.showSuccessSnackbar(
          context, "Profile updated successfully");
    });
  }
}
