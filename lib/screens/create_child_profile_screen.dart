import 'package:flutter/material.dart';
import 'package:parent/screens/select_child.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_validator/form_validator.dart';
import 'package:parent/constants/db_constants.dart';
import 'package:parent/services/snackbar_service.dart';

class CreateChildProfile extends StatefulWidget {
  final String? uid;
  final void Function() successCallback;
  const CreateChildProfile({
    Key? key,
    required this.uid,
    required this.successCallback,
  }) : super(key: key);

  @override
  State<CreateChildProfile> createState() => _CreateChildProfileState();
}

class _CreateChildProfileState extends State<CreateChildProfile> {
  late String _uidChild;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _parentCollection =
      _firestore.collection(DBConstants.parentCollectionName);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = false;

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
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter UID',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _uidChild = value.trim();
                          });
                        },
                        validator: ValidationBuilder().required().build(),
                      ),
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
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          if (!_loading) {
                            setState(() {
                              _loading = true;
                            });
                            _addChild(_uidChild, widget.uid);
                          }
                        }
                      },
                      color: const Color.fromARGB(255, 116, 49, 128),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _loading
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

  void _addChild(_uidChild, parentUID) async {
    bool _isDuplicate = false;
    DocumentReference documentReferencer = _parentCollection.doc(parentUID);
    DocumentSnapshot parentDataSnapshot = await documentReferencer.get();
    Map<String, dynamic>? parentData =
        parentDataSnapshot.data() as Map<String, dynamic>;

    // Getting children array from document
    List children = parentData['children'];
    for (int i = 0; i < children.length; i++) {
      if (children[i] == _uidChild) {
        _isDuplicate = true;
        SnackbarService.showInfoSnackbar(context, 'Child already registered!!');
        setState(() {
          _loading = false;
        });
        break;
      }
    }
    if (!_isDuplicate) {
      children.add(_uidChild);
      Map<String, dynamic> data = <String, dynamic>{
        "children": children,
      };
      await documentReferencer.update(data).then((v) {
        widget.successCallback();
        SnackbarService.showSuccessSnackbar(context, 'Child registered!!');
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        SnackbarService.showErrorSnackbar(
            context, 'Some error occured!! Please try after some time.');
        setState(() {
          _loading = false;
        });
      });
    }
  }
}
