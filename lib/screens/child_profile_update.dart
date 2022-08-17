import 'package:flutter/material.dart';

class ChildProfileUpdate extends StatefulWidget {
  const ChildProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ChildProfileUpdate> createState() => _ChildProfileUpdateState();
}

class _ChildProfileUpdateState extends State<ChildProfileUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 210, 248),
      appBar: AppBar(
        title: const Text("Child Profile Update",
            style: TextStyle(color: Color.fromARGB(255, 247, 244, 244))),
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
              style:
                  TextStyle(color: Color.fromARGB(255, 10, 9, 9), fontSize: 40),
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
                prefixIcon: Icon(Icons.person),
                hintText: 'Enter The Name',
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
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'Enter New Email',
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
                prefixIcon: Icon(Icons.phone),
                hintText: 'Enter New Phone No.',
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
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),

            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_view_day),
                hintText: 'Enter New Class',
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
