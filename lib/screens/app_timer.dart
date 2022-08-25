import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/db_constants.dart';

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final int y;
}

class Apptimer extends StatefulWidget {
  final List appData;
  final String? UID;
  const Apptimer({Key? key, required this.appData, required this.UID})
      : super(key: key);
  @override
  State<Apptimer> createState() => _Apptimer();
}

class _Apptimer extends State<Apptimer> {
  void initState() {
    super.initState();
  }

  final TimeOfDay? newTime = TimeOfDay(hour: 0, minute: 0);
  num timemin = 0;
  void _sectTime(String appName) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (newTime != null) {
      timemin = ((newTime!.hour * 60) + (newTime!.minute));
      updateChildData(appName);
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference childCollection =
      _firestore.collection(DBConstants.childCollectionName);
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
                        onPressed: () => _sectTime(app.x.toString()),
                        child: const Icon(
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

  void updateChildData(String appName) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    late final CollectionReference _childCollection =
        _firestore.collection(DBConstants.childCollectionName);
    DocumentReference documentReferencer = _childCollection.doc(widget.UID);
    DocumentSnapshot ChildrenDataSnapshot = await documentReferencer.get();
    Map<String, dynamic>? childData =
        ChildrenDataSnapshot.data() as Map<String, dynamic>;
    childData['apps'].keys.forEach((app) {
      if (childData['apps'][app]['app_name'] == appName) {
        childData['apps'][app]['max_screen_time'] = timemin;
      }
    });

    await documentReferencer
        .update(childData)
        .then((v) => print('Update Max_Screen_Time'));
  }
}
