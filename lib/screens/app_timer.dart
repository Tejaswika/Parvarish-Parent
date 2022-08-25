import 'package:flutter/material.dart';

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final int y;
}

class Apptimer extends StatefulWidget {
  final List appData;
  const Apptimer({Key? key, required this.appData}) : super(key: key);
  @override
  State<Apptimer> createState() => _Apptimer();
}

class _Apptimer extends State<Apptimer> {
  void initState() {
    print(widget.appData);

    super.initState();
  }

  final TimeOfDay? newTime = TimeOfDay(hour: 0, minute: 0);
  void _sectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 7, minute: 15),
        initialEntryMode: TimePickerEntryMode.input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Timer',
          style: TextStyle(color: Colors.white),
        ),
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                ...widget.appData.map(
                  (app) => Card(
                    child: ListTile(
                      title: Text(app.x + "\n" + app.y.toString() + " min"),
                      trailing: ElevatedButton(
                        onPressed: _sectTime,
                        child: Icon(
                          Icons.timer,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                )
                // ListView(
                //   shrinkWrap: true,
                //   children: const <Widget>[
                //     ListTile(
                //       leading: Icon(Icons.video_call),
                //       title: Text('YouTube'),
                //       trailing: Icon(Icons.timer),
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.chat),
                //       title: Text('WhatsApp'),
                //       trailing: Icon(Icons.timer),
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.tiktok_outlined),
                //       title: Text('Tiktok'),
                //       trailing: Icon(Icons.timer),
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.music_note),
                //       title: Text('Music'),
                //       trailing: Icon(Icons.timer),
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.snapchat),
                //       title: Text('SnapChat'),
                //       trailing: Icon(Icons.timer),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
