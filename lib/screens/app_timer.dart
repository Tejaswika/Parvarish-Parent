import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/db_constants.dart';

import 'package:flutter/gestures.dart';

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final int y;
}

class Apptimer extends StatefulWidget {
  final List appData;
  final String? uid;
  const Apptimer({Key? key, required this.appData, required this.uid})
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
  List checkBox = [];
  bool value = false;
  void _sectTime(List appName) async {
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
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(children: [
                  const SizedBox(
                    width: 18,
                  ),
                  Checkbox(
                    value: this.value,
                    onChanged: (bool? value) {
                      if (value!) {
                        setState(() {
                          this.value = value!;
                          widget.appData.forEach((app) {
                            checkBox.add(app.x);
                          });
                        });
                      } else {
                        setState(() {
                          this.value = value!;
                          widget.appData.forEach((app) {
                            checkBox.remove(app.x);
                          });
                        });
                      }
                      print(checkBox);
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => {_sectTime(checkBox)},
                    child: Text("Set Timer",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(39, 28, 162, 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ]),

                const SizedBox(
                  height: 15,
                ),
                ...widget.appData.map(
                  (app) {
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: checkBox.contains(app.x),
                          onChanged: (bool? value) {
                            if (value!) {
                              setState(() {
                                checkBox.add(app.x);
                              });
                            } else {
                              setState(() {
                                checkBox.remove(app.x);
                              });
                            }
                            print(checkBox);
                          },
                        ),
                        title: Text(app.x + "\n" + app.y.toString() + " min"),
                        trailing: ElevatedButton(
                          onPressed: () => {
                            checkBox.add(app.x),
                            _sectTime(checkBox),
                          },
                          child: const Icon(
                            Icons.timer,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    );
                  },
                )
                //            ListView(
                //   children: values.keys.map((String key) {
                //     return new CheckboxListTile(
                //       title: new Text(key),
                //       value: values[key],
                //       onChanged: (bool value) {
                //         setState(() {
                //           values[key] = value;
                //         });
                //       },
                //     );
                //   }).toList(),
                // ),
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

  void updateChildData(List checkBox) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    late final CollectionReference _childCollection =
        _firestore.collection(DBConstants.childCollectionName);
    DocumentReference documentReferencer = _childCollection.doc(widget.uid);
    DocumentSnapshot ChildrenDataSnapshot = await documentReferencer.get();
    Map<String, dynamic>? childData =
        ChildrenDataSnapshot.data() as Map<String, dynamic>;
    childData['apps'].keys.forEach((app) {
      checkBox.forEach((checked) {
        if (childData['apps'][app]['app_name'] == checked.toString()) {
          childData['apps'][app]['max_screen_time'] = timemin;
        }
      });
    });

    await documentReferencer
        .update(childData)
        .then((v) => print('Update Max_Screen_Time'));
  }
}
