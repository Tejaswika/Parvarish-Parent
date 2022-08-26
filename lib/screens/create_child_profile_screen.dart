import 'package:flutter/material.dart';
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
  late final CollectionReference _childCollection =
      _firestore.collection(DBConstants.childCollectionName);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        // centerTitle: true,
        title: const Text(
          'Add Child',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // Container(
          //   padding: const EdgeInsets.only(left: 35, top: 50),
          //   child: Text(
          //     'Add Child Unique ID',
          //     style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24,),
          //   ),
          // ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(50, 150, 50, 10),
            height: 600,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter Child's unique Id",
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
                    color: Theme.of(context).colorScheme.primary,
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
        ]),
      ),
    );
  }

  void _addChild(_uidChild, parentUID) async {
    bool _isDuplicate = false;
    List<String> parentId = [];
    DocumentReference documentReferencerParent =
        _parentCollection.doc(parentUID);
    DocumentSnapshot parentDataSnapshot = await documentReferencerParent.get();
    DocumentReference documentReferenceChild = _childCollection.doc(_uidChild);
    DocumentSnapshot childDataSnapshot = await documentReferenceChild.get();
    Map<String, dynamic>? childData =
        childDataSnapshot.data() as Map<String, dynamic>;
    print(childData);
    Map<String, dynamic>? parentData =
        parentDataSnapshot.data() as Map<String, dynamic>;
    parentId.add(parentUID);
    childData["parent_id"] = parentUID;
    documentReferenceChild.update(childData);
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
      await documentReferencerParent.update(data).then((v) {
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
