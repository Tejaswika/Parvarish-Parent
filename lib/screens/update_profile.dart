import 'package:flutter/material.dart';



class UpdateProfile extends StatefulWidget {
  final String? childId;
  final Map<String, dynamic>? parentData;
  const UpdateProfile(
      {Key? key, required this.childId, required this.parentData})
      : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late String? parentName=widget.parentData!["name"];
  late String? parentEmail=widget.parentData!["email"];
  late String? parentPhone=widget.parentData!["phone"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 210, 248),
      appBar: AppBar(
        title: const Text("Personal Details",
            style: TextStyle(color: Color.fromARGB(255, 9, 9, 9))),
        elevation: 0.0,
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(left: 80, top: 32),
            child: const Text(
              'Profile Update',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              decoration:  InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: parentName,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 236, 236),
                borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: parentEmail,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              decoration:  InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                hintText: parentPhone,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),

            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_view_day),
                hintText: 'Enter New Age',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 130),
            child: TextButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.only(
                    left: 80, right: 80, top: 16, bottom: 16),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 9, 9, 9),
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Color.fromARGB(255, 233, 231, 231)),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
