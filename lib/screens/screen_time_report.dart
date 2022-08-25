import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/app_timer.dart';
import '../screens/screen_time.dart';
import '../constants/db_constants.dart';

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
  late List<_ChartData> childAppsDataDaily = [];
  late List<_ChartData> childAppsDataWeekly = [];
  late List<_ChartData> childAppsDataMonthly = [];
  late TooltipBehavior _tooltip;
  late Future<Map<String, dynamic>?> appsData;
  late num totalAppHrsDaily = 0;
  late num currentAppMinDaily = 0;
  late num currentAppHrsDaily = 0;
  late num currentTotalHrsTime = 0;
  late num currentTotalMinTime = 0;
  late String totalScreenTime = '';
  // ignore: library_private_types_in_public_api
  List<_ChartData> currentAppList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _childCollection =
      _firestore.collection(DBConstants.childCollectionName);
// ignore: non_constant_identifier_names
  Map<String, dynamic>? AppUsagechildData;
  Map<String, dynamic>? apps;
  bool _loading = true;

  Future readchildData(uid) async {
    DocumentReference documentReferencer = _childCollection.doc(uid);
    await documentReferencer.get().then((DocumentSnapshot childDataSnapshot) {
      AppUsagechildData = childDataSnapshot.data() as Map<String, dynamic>;
      apps = AppUsagechildData!['apps'];
      graphData();
    });
  }

  void graphData() {
    apps?.forEach((key, app) {
      childAppsDataDaily.add(
          _ChartData(app['app_name'], app['current_day_screen_time'] ?? 0));

      totalAppHrsDaily =
          totalAppHrsDaily + (app['current_day_screen_time'] ?? 0);
    });

    childAppsDataDaily.sort((appData1, appData2) {
      if (appData1.y > appData2.y) return -1;
      return 1;
    });
    currentAppList = childAppsDataDaily;
    currentTotalHrsTime = totalAppHrsDaily ~/ 60;
    currentTotalMinTime = totalAppHrsDaily % 60;
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
    List<_ChartData> graphData = [];
    if (currentAppList.isNotEmpty) {
      graphData = currentAppList.sublist(0, 5);
    }
    return Scaffold(
        body: SafeArea(
      child: _loading && currentAppList.isNotEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                widget:
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                        child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text: 'Today \n',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Color.fromARGB(
                                                  255, 0, 0, 0))),
                                      TextSpan(
                                          text: currentTotalHrsTime.toString() +
                                              " H " +
                                              currentTotalMinTime.toString() +
                                              " Min",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: Color.fromARGB(
                                                  255, 0, 0, 0))),
                                    ],
                                  ),
                                )),
                              )
                            ],
                            series: <CircularSeries>[
                              // Renders doughnut chart
                              DoughnutSeries<_ChartData, String>(
                                dataSource: graphData,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                innerRadius: "80%",
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                ),
                              )
                            ])),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'All units are measured in minutes',
                          style:
                              TextStyle(color: Color.fromARGB(255, 59, 56, 56)),
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    // ignore: avoid_unnecessary_containers
                    ...graphData.map(
                      (_ChartData appData) => Card(
                        child: ListTile(
                          title: Text(appData.x),
                          trailing: Text((appData.y ~/ 60).toString() +
                              " H " +
                              (appData.y % 60).toString() +
                              " M"),
                        ),
                      ),
                    ),

                    // ignore: avoid_unnecessary_containers
                    Container(
                        child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Your App Stats',
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
                            title: const Text('Set App Timer'),
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) => Apptimer(
                                          appData:
                                              childAppsDataDaily.toList())));
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
                            title: const Text('Your App Status'),
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
