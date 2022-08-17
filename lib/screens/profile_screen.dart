import 'package:flutter/material.dart';
import 'package:parent/screens/child_profile_update.dart';
import 'package:parent/screens/create_new_password.dart';
import 'package:parent/screens/update_profile.dart';

final List<String> imagesList = [
  'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
  'https://cdn-icons-png.flaticon.com/512/2922/2922510.png',
  'https://cdn-icons-png.flaticon.com/512/2922/2922575.png',
];
final List<String> titles = [
  ' Neha Singh ',
  ' Raj Kumar ',
  ' Preeti Pandey ',
];

class ProfileScreen extends StatefulWidget {
  final String? childId;
  final Map<String, dynamic>? parentData;
  const ProfileScreen({Key? key,required this.childId,required this.parentData}) : super(key: key);

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
                            builder: (context) => UpdateProfile(parentData: widget.parentData,childId: widget.childId,)))),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    onTap: (() => Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => const NewPassword()))),
                    title: const Text('Change Password'),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    onTap: (() => Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => const ChildProfileUpdate()))),
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
