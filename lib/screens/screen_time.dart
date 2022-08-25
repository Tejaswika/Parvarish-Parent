import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/db_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String? UID;
  // ignore: non_constant_identifier_names
  const TimeScreen({Key? key, required this.UID}) : super(key: key);

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _childCollection =
      _firestore.collection(DBConstants.childCollectionName);
// ignore: non_constant_identifier_names
  Map<String, dynamic>? AppUsagechildData;
  Map<String, dynamic>? apps;
  bool _loading = true;

  late List<_ChartData> childAppsDataDaily = [];
  late List<_ChartData> childAppsDataWeekly = [];
  late List<_ChartData> childAppsDataMonthly = [];
  late TooltipBehavior _tooltip;
  late Future<Map<String, dynamic>?> appsData;
  late num totalAppHrsDaily = 0;
  late num totalAppHrsWeekly = 0;
  late num totalAppHrsMonthly = 0;
  late num currentAppMinDaily = 0;
  late num currentAppHrsDaily = 0;
  late num currentAppMinWeekly = 0;
  late num currentAppHrsWeekly = 0;
  late num currentAppMinMonthly = 0;
  late num currentAppHrsMonthly = 0;
  late num currentTotalHrsTime = 0;
  late num currentTotalMinTime = 0;
  late num currentTotalTime = 0;

  // ignore: library_private_types_in_public_api
  List<_ChartData> currentAppList = [];
  String dropdownvalue = 'Daily';
  String listViewHeadingNames = 'Daily Apps Time';

  // List of items in our dropdown menu
  var items = [
    'Daily',
    'Weekly',
    'Monthly',
  ];

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
      childAppsDataMonthly.add(
          _ChartData(app['app_name'], app['current_month_screen_time'] ?? 0));
      childAppsDataWeekly.add(
          _ChartData(app['app_name'], app['current_week_screen_time'] ?? 0));

      totalAppHrsDaily =
          totalAppHrsDaily + (app['current_day_screen_time'] ?? 0);
      totalAppHrsWeekly =
          totalAppHrsWeekly + (app['current_week_screen_time'] ?? 0);
      totalAppHrsMonthly =
          totalAppHrsMonthly + (app['current_month_screen_time'] ?? 0);
    });

    childAppsDataDaily.sort((appData1, appData2) {
      if (appData1.y > appData2.y) return -1;
      return 1;
    });

    childAppsDataWeekly.sort((appData1, appData2) {
      if (appData1.y > appData2.y) return -1;
      return 1;
    });

    childAppsDataMonthly.sort((appData1, appData2) {
      if (appData1.y > appData2.y) return -1;
      return 1;
    });

    if (dropdownvalue == "Daily") {
      currentAppList = childAppsDataDaily;
      currentTotalHrsTime = totalAppHrsDaily ~/ 60;
      currentTotalMinTime = totalAppHrsDaily % 60;
      listViewHeadingNames = 'Daily Apps Time';
    } else if (dropdownvalue == "Weekly") {
      currentAppList = childAppsDataWeekly;
      currentTotalHrsTime = totalAppHrsWeekly ~/ 60;
      currentTotalMinTime = totalAppHrsWeekly % 60;
      listViewHeadingNames = 'Weekly Apps Time';
    } else {
      currentAppList = childAppsDataMonthly;
      currentTotalHrsTime = totalAppHrsMonthly ~/ 60;
      currentTotalMinTime = totalAppHrsMonthly % 60;
      listViewHeadingNames = 'Monthly Apps Time';
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    readchildData(widget.UID);
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<_ChartData> graphData = [];
    if (currentAppList.isNotEmpty) {
      graphData = currentAppList.sublist(0, 5);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Screen Time',
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
        child: _loading && currentAppList.isNotEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Total Screen Time \n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            TextSpan(
                              text: currentTotalHrsTime.toString()+ " H "+ currentTotalMinTime.toString()+ " Min",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 190, 190, 190),
                              ),
                            ),
                          ],
                        ),
                      ),
                      DropdownButton(
                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            if (dropdownvalue == "Daily") {
                              currentAppList = childAppsDataDaily;
                              currentTotalHrsTime = totalAppHrsDaily ~/ 60;
                              currentTotalMinTime = totalAppHrsDaily % 60;
                              listViewHeadingNames = 'Daily Apps Time';
                            }
                            if (dropdownvalue == "Weekly") {
                              currentAppList = childAppsDataWeekly;
                              currentTotalHrsTime = totalAppHrsWeekly ~/ 60;
                              currentTotalMinTime = totalAppHrsWeekly % 60;
                              listViewHeadingNames = 'Weekly Apps Time';
                            }
                            if (dropdownvalue == "Monthly") {
                              currentAppList = childAppsDataMonthly;
                              currentTotalHrsTime = totalAppHrsMonthly ~/ 60;
                              currentTotalMinTime = totalAppHrsMonthly % 60;
                              listViewHeadingNames = 'Monthly Apps Time';
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: 280,
                        child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(),
                            tooltipBehavior: _tooltip,
                            series: <CartesianSeries>[
                              ColumnSeries<_ChartData, String>(
                                dataSource: graphData,
                                xValueMapper: (_ChartData list2, _) => list2.x,
                                yValueMapper: (_ChartData list2, _) => list2.y,
                                width: 0.6,
                                spacing: 0.3,
                                // sortingOrder: SortingOrder.descending,
                                // Sorting based on the specified field
                                // sortFieldValueMapper: (_ChartData list2, _) =>
                                //     list2.y,
                              ),
                            ]),
                      ),
                      const SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          listViewHeadingNames,
                          style: const TextStyle(
                              fontSize: 30.0, fontFamily: 'Times'),
                        ),
                      ),
                      ...currentAppList.map(
                        (_ChartData appData) => Card(
                          child: ListTile(
                            title: Text(appData.x),
                            trailing: Text((appData.y~/60).toString()+" H "+(appData.y % 60).toString() + " Min"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final int y;
}
