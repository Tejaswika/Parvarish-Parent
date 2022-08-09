import 'package:flutter/material.dart';
import 'package:parent/screens/my_nav_pill.dart';

class Apptimer extends StatelessWidget {
  const Apptimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 233, 233),
        appBar: AppBar(
          title: const Text("App timers"),
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: (() => {}),
              icon: const Icon(Icons.settings),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyNavPill(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  hintText: "Search Apps",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView(
                shrinkWrap: true,
                children: const <Widget>[
                  ListTile(
                    leading: Icon(Icons.video_call),
                    title: Text('YouTube'),
                    trailing: Icon(Icons.timer),
                  ),
                  ListTile(
                    leading: Icon(Icons.chat),
                    title: Text('WhatsApp'),
                    trailing: Icon(Icons.timer),
                  ),
                  ListTile(
                    leading: Icon(Icons.tiktok_outlined),
                    title: Text('Tiktok'),
                    trailing: Icon(Icons.timer),
                  ),
                  ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text('Music'),
                    trailing: Icon(Icons.timer),
                  ),
                  ListTile(
                    leading: Icon(Icons.snapchat),
                    title: Text('SnapChat'),
                    trailing: Icon(Icons.timer),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
