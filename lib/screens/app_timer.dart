import 'package:flutter/material.dart';

class Apptimer extends StatefulWidget {
  final Map<String, dynamic>? appData;
  const Apptimer({Key? key, required this.appData}) : super(key: key);
  @override
  State<Apptimer> createState() => _Apptimer();
}

class _Apptimer extends State<Apptimer> {
  void initState() {
    print(widget.appData);
    super.initState();
  }

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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
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
