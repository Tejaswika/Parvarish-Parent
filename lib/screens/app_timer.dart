import 'package:flutter/material.dart';
import 'package:parent/screens/my_nav_pill.dart';
import 'package:parent/screens/app_timer.dart';

class Apptimer extends StatelessWidget {
  const Apptimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 233, 233),
        appBar: AppBar(
          title: Text("App timers"),
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: (() => {}),
              icon: Icon(Icons.settings),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyNavPill()));
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                  hintText: "Search Apps",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.video_call),
                      title: Text('YouTube'),
                      trailing: Icon(Icons.timer),
                    ),
                    ListTile(
                      leading: Icon(Icons.chat),
                      title: Text('WhatsApp'),
                      trailing: const Icon(Icons.timer),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
