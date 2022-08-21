import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/app_timer.dart';
import '../screens/screen_time.dart';
import '../constants/db_constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _childCollection =
    _firestore.collection(DBConstants.childCollectionName);
// ignore: non_constant_identifier_names
Map<String, dynamic>? AppUsagechildData;
Map<String, dynamic>? apps;
bool _loading = true;

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final int y;
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

  Future readchildData(uid) async {
    DocumentReference documentReferencer = _childCollection.doc(uid);
    DocumentSnapshot childDataSnapshot = await documentReferencer.get();

    AppUsagechildData = childDataSnapshot.data() as Map<String, dynamic>;

    apps = AppUsagechildData!['apps'];
    setState(() {
      _loading = false;
    });

    graphUpdate();
  }

  void graphUpdate() {
    if (_loading == false) {
      apps?.forEach((key, app) {
        childApps
            .add(_ChartData(app['app_name'], app['current_day_screen_time']));
        totalAppHrs = totalAppHrs + app['current_day_screen_time'];
      });
      totalAppHrs = totalAppHrs ~/ 60;
      totalScreenTime = totalAppHrs.toString();

      list2 = childApps.where((map) => map.y > 20).toList();
    }
  }

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);

    readchildData(widget.UID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Total Screen Time \n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Color.fromARGB(255, 0, 0, 0))),
                  TextSpan(
                      text: totalScreenTime,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0))),
                  const TextSpan(
                      text: ' hours',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 190, 190, 190))),
                ],
              ),
            ),
            SizedBox(
              height: 280,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                  tooltipBehavior: _tooltip,
                  series: <CartesianSeries>[
                    ColumnSeries<_ChartData, String>(
                        dataSource: list2,
                        xValueMapper: (_ChartData list2, _) => list2.x,
                        yValueMapper: (_ChartData list2, _) => list2.y,
                        width: 0.6,
                        spacing: 0.3,
                        sortingOrder: SortingOrder.descending,
                        // Sorting based on the specified field
                        sortFieldValueMapper: (_ChartData list2, _) => list2.y),
                  ]),
            ),
            const ListTile(
              leading: Icon(Icons.video_call),
              title: const Text('YouTube'),
            ),
            const ListTile(
              leading: Icon(Icons.chat),
              title: Text('WhatsApp'),
            ),
            const ListTile(
              leading: Icon(Icons.snapchat),
              title: Text('SnapChat'),
            ),
            RichText(
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
            ),
            ListTile(
              leading: const Icon(Icons.lock_clock),
              title: const Text('App Timer'),
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => const Apptimer()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_clock),
              title: const Text('Screen Timer'),
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        builder: (context) => const TimeScreen()));
              },
            ),
          ],
        ),
      ),
    ));
  }
}
