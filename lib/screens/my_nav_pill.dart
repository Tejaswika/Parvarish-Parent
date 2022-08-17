import 'package:flutter/material.dart';
import './profile_screen.dart';

import './quiz_screen.dart';
import 'package:parent/screens/app_timer.dart';
import 'package:parent/screens/screen_time.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/new_quiz.dart';

import 'package:parent/constants/db_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _childCollection =
    _firestore.collection(DBConstants.childCollectionName);

// ignore: non_constant_identifier_names
Map<String, dynamic>? AppUsagechildData;
Map<String, dynamic>? apps;
bool _loading = true;

//Store this globally
final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class MyNavPill extends StatefulWidget {
  final Map<String, dynamic>? childData;
  final String? childId;
  final Map<String, dynamic>? parentData;
  const MyNavPill({Key? key, required this.childData, required this.childId,required this.parentData})
      : super(key: key);

  @override
  _MyNavPillState createState() => _MyNavPillState();
}

class _MyNavPillState extends State<MyNavPill>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  void _createQuiz(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (_) {
          return NewQuiz(childData: widget.childData, childId: widget.childId);
          // behavior: HitTestBehavior.deferToChild,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: () => _createQuiz(context),
        //     icon: const Icon(Icons.add, color: Colors.white),
        //   ),
        // ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Parvarish',
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text('Report'),
            ),
            Tab(
              child: Text('Quiz'),
            ),
            Tab(
              child: Text('Profile'),
            ),
          ],
        ),
      ),
      body: Navigator(
        key: _navKey,
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => TabBarView(
            controller: _tabController,
            children: [
              FirstPage(
                childId: widget.childId,
              ),
              QuizScreen(createQuiz: _createQuiz),
              ProfileScreen(childId: widget.childId,parentData: widget.parentData,),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class FirstPage extends StatefulWidget {
  final String? childId;

  const FirstPage({Key? key, required this.childId}) : super(key: key);

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  late List<_ChartData> childApps = [];
  late TooltipBehavior _tooltip;
  late Future<Map<String, dynamic>?> appsData;
  late num totalAppHrs = 0;
  late String totalScreenTime = '';
  List<_ChartData> list2 = [];

  Future readchildData(uid) async {
    DocumentReference documentReferencer = _childCollection.doc(uid);
    DocumentSnapshot childDataSnapshot = await documentReferencer.get();

    AppUsagechildData = childDataSnapshot.data() as Map<String, dynamic>;

    apps = AppUsagechildData!['apps'];
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    readchildData(widget.childId);
    
      apps?.forEach((key, app) {
        childApps
            .add(_ChartData(app['app_name'], app['current_day_screen_time']));
        totalAppHrs = totalAppHrs + app['current_day_screen_time'];
      });
      totalAppHrs = totalAppHrs ~/ 60;
      totalScreenTime = totalAppHrs.toString();
      list2 = childApps.where((map) => map.y > 20).toList();
      _loading =true;
    
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 5.0,
            spacing: 10.0,
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
                          sortFieldValueMapper: (_ChartData list2, _) =>
                              list2.y),
                    ]),
              ),
              ListView(
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
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Your Goal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: const Text('App Timer'),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => const Apptimer(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock_clock),
                    title: const Text('Screen Timer'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TimeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
