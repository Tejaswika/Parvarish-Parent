import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blueGrey[800]),
        )),
      ),
      home: MyNavPill()));
}

//Store this globally
final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class MyNavPill extends StatefulWidget {
  MyNavPill({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parvarish'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text('Report'),
            ),
            Tab(
              child: Text('Quiz'),
            ),
            Tab(
              child: Text('Setting'),
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
              _FirstPage(),
              SecondPage(),
              ThridPage(),
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

class _FirstPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _FirstPage({Key? key}) : super(key: key);

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<_FirstPage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('', 10),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 5.0,
          spacing: 10.0,
          children: [
            Container(
                child: RichText(
              text: TextSpan(
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Screen Time \n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 0, 0, 0))),
                  TextSpan(
                      text: '3h 8m \n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color.fromARGB(255, 0, 0, 0))),
                  TextSpan(
                      text: '3h',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 0, 0, 0))),
                  TextSpan(
                      text: ' less than yesterday',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 190, 190, 190))),
                ],
              ),
            )),
            Container(
              height: 150,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      minimum: 0, maximum: 20, interval: 20, isVisible: false),
                  tooltipBehavior: _tooltip,
                  series: <ChartSeries<_ChartData, String>>[
                    BarSeries<_ChartData, String>(
                        dataSource: data,
                        isTrackVisible: false,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        name: 'Gold',
                        color: Color.fromRGBO(8, 142, 255, 1))
                  ]),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
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
            Container(
                child: RichText(
              text: TextSpan(
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Your Goal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 0, 0, 0))),
                ],
              ),
            )),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.timer),
                    title: Text('App Timer'),
                  ),
                  ListTile(
                    leading: Icon(Icons.lock_clock),
                    title: Text('Screen Timer'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Second Page'),
          ],
        ),
      ),
    );
  }
}

class ThridPage extends StatelessWidget {
  const ThridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Thrid Page'),
          ],
        ),
      ),
    );
  }
}
