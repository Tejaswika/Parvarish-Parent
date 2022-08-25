import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class QuizReport extends StatefulWidget {
  final Function createQuiz;
  const QuizReport({Key? key, required this.createQuiz}) : super(key: key);

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => widget.createQuiz(context),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Text(
                  'Average Marks: 45\n',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const Text(
                  'Passing Percentage: 50\n',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<_ChartData, String>>[
                      ColumnSeries<_ChartData, String>(
                          dataSource: data,
                          
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          width: 0.6,
                          spacing: 0.3,
                          color: const Color.fromRGBO(8, 142, 255, 1))
                    ],
                  ),
                ),
                const ListTile(
                  title: Text('Last attempted quizes',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                ),
                const ListTile(
                  title: Text('Maths Quiz'),
                  trailing: Text('60%'),
                ),
                const ListTile(
                  title: Text('English Quiz'),
                  trailing: Text('70%'),
                ),
                const ListTile(
                  title: Text('Environmental Studies Quiz'),
                  trailing: Text('80%'),
                ),
                const ListTile(
                  title: Text('Computer Quiz'),
                  trailing: Text('75%'),
                ),
                const ListTile(
                  title: Text('General Knowledge Quiz'),
                  trailing: Text('70%'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
