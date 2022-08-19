import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class QuizReport extends StatefulWidget {
  const QuizReport({Key? key}) : super(key: key);

  @override
  _QuizReportState createState() => _QuizReportState();
}

class _QuizReportState extends State<QuizReport> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Maths', 40),
      _ChartData('Computer', 20),
      _ChartData('Environmental Studies', 30),
      _ChartData('General Knowledge', 25),
      _ChartData('English', 20),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 5.0,
            spacing: 10.0,
            children: [
              const Text(
                'Average Marks: 45\n',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 22,
                  // color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const Text(
                'Passing Percentage: 50\n',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 22,
                  // color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(
                height: 200,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 50,
                        interval: 10,
                        isVisible: false),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<_ChartData, String>>[
                      BarSeries<_ChartData, String>(
                          dataSource: data,
                          isTrackVisible: false,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          name: ' ',
                          color: const Color.fromRGBO(8, 142, 255, 1))
                    ]),
              ),
              ListView(
                shrinkWrap: true,
                children: const <Widget>[
                  ListTile(
                    //title: Text('Last attempted quizes'),
                    title: Text('Last attempted quizes',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20)),
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
