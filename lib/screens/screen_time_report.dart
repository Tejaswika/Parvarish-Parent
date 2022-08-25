import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/app_timer.dart';
import '../screens/screen_time.dart';
import '../constants/db_constants.dart';

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}

class ScreenTimeReport extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables, non_constant_identifier_names
  final String? UID;

  // ignore: non_constant_identifier_names
  const ScreenTimeReport({Key? key, required this.UID}) : super(key: key);

  @override
  ScreenTimeReportState createState() => ScreenTimeReportState();
}

class ScreenTimeReportState extends State<ScreenTimeReport> {
  // ignore: library_private_types_in_public_api
  late List<_ChartData> childApps = [];
  late TooltipBehavior _tooltip;
  late Future<Map<String, dynamic>?> appsData;
  late num totalAppHrs = 0;
  late String totalScreenTime = '';
  // ignore: library_private_types_in_public_api
  List<_ChartData> list2 = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _childCollection =
      _firestore.collection(DBConstants.childCollectionName);
// ignore: non_constant_identifier_names
  Map<String, dynamic>? AppUsagechildData;
  Map<String, dynamic>? apps;
  bool _loading = true;

  Future readchildData(uid) async {
    DocumentReference documentReferencer = _childCollection.doc(uid);
    DocumentSnapshot childDataSnapshot = await documentReferencer.get();

    AppUsagechildData = childDataSnapshot.data() as Map<String, dynamic>;

    apps = AppUsagechildData!['apps'];
    graphData();
  }

  void graphData() {
    apps?.forEach((key, app) {
      childApps
          .add(_ChartData(app['app_name'], app['current_day_screen_time'].toDouble()));
      totalAppHrs = totalAppHrs + app['current_day_screen_time'];
    });
    totalAppHrs = totalAppHrs ~/ 60;
    totalScreenTime = totalAppHrs.toString();

    list2 = childApps.where((map) => map.y > 20).toList();
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);

    readchildData(widget.UID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_loading);
    print(list2);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 5.0,
            spacing: 10.0,
            children: [
              // ignore: avoid_unnecessary_containers

              SizedBox(
                  height: 350,
                  child: SfCircularChart(
                      legend: Legend(isVisible: true),
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          widget: Container(
                              child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Today \n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 0, 0, 0))),
                                TextSpan(
                                    text: totalScreenTime,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Color.fromARGB(255, 0, 0, 0))),
                                const TextSpan(
                                    text: ' hours',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Color.fromARGB(
                                            255, 190, 190, 190))),
                              ],
                            ),
                          )),
                        )
                      ],
                      series: <CircularSeries>[
                        // Renders doughnut chart
                        DoughnutSeries<_ChartData, String>(
                          dataSource: list2,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          innerRadius: "80%",
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                          ),
                        )
                      ])),

              // ignore: avoid_unnecessary_containers
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: const <Widget>[
                    ListTile(
                      leading: Icon(Icons.video_call),
                      title: Text('YouTube'),
                    ),
                    ListTile(
                      leading: Icon(Icons.chat),
                      title: Text('WhatsApp'),
                    ),
                    ListTile(
                      leading: Icon(Icons.snapchat),
                      title: Text('SnapChat'),
                    ),
                  ],
                ),
              ),

              // ignore: avoid_unnecessary_containers
              Container(
                  child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Your Goal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
              )),

              // ignore: avoid_unnecessary_containers
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.lock_clock),
                      title: const Text('App Timer'),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => Apptimer(appData: apps)));
                      },
                    ),
                  ],
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.lock_clock),
                      title: const Text('Screen Timer'),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    TimeScreen(UID: widget.UID)));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
