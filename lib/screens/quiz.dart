import 'dart:ui';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class QuizReport extends StatefulWidget {
  QuizReport({Key? key}) : super(key: key);

  @override
  _QuizReportState createState() => _QuizReportState();
}

class _QuizReportState extends State<QuizReport> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Whatsapp', 10),
      _ChartData('Instagram', 20),
      _ChartData('Facebook', 30),
      _ChartData('Spotify', 5),
      _ChartData('Amazon', 20),
      _ChartData('Flipkart', 10),
      _ChartData('Google', 30),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 180, 231),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Wrap(runSpacing: 5.0, spacing: 10.0, children: [
            Container(
                child: RichText(
              text: TextSpan(
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Quiz Report \n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 0, 0, 0))),
                  TextSpan(
                      text: 'Average Marks:45\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color.fromARGB(255, 0, 0, 0))),
                  TextSpan(
                      text: 'Passing Percentage:50\n',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 190, 190, 190))),
                ],
              ),
            )),
            Container(
              height: 200,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      minimum: 0, maximum: 50, interval: 10, isVisible: false),
                  tooltipBehavior: _tooltip,
                  series: <ChartSeries<_ChartData, String>>[
                    BarSeries<_ChartData, String>(
                        dataSource: data,
                        isTrackVisible: false,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        name: ' ',
                        color: Color.fromRGBO(8, 142, 255, 1))
                  ]),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text('Maths Quiz'),
                    trailing: Text('60%'),
                  ),
                  ListTile(
                    title: Text('English Quiz'),
                    trailing: Text('70%'),
                  ),
                  ListTile(
                    title: Text('Environmental Studies Quiz'),
                    trailing: Text('80%'),
                  ),
                  ListTile(
                    title: Text('Computer Quiz'),
                    trailing: Text('75%'),
                  ),
                  ListTile(
                    title: Text('General Knowledge Quiz'),
                    trailing: Text('70%'),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
