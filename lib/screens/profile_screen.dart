import 'package:flutter/material.dart';
import 'package:parent/screens/child_profile_update_screen.dart';
import 'package:parent/screens/change_password_screen.dart';
import 'package:parent/screens/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? parentId;
  final String? childId;
  final Map<String, dynamic>? parentData;
  final Map<String, dynamic>? childData;
  const ProfileScreen(
      {Key? key,
      required this.childData,
      required this.parentId,
      required this.childId,
      required this.parentData})
      : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Wrap(
            runSpacing: 5.0,
            spacing: 10.0,
            children: [
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    onTap: (() => Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => UpdateProfile(
                                  parentId: widget.parentId,
                                  parentData: widget.parentData,
                                  childId: widget.childId,
                                )))),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    onTap: (() => Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => const ChangePassword()))),
                    title: const Text('Add Child'),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    onTap: (() => Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => ChildProfileUpdate(
                                childData: widget.childData,
                                childId: widget.childId)))),
                    title: const Text('Edit Child Profile'),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
