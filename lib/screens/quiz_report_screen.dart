import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants/db_constants.dart';
import 'package:flutter/material.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class QuizReport extends StatefulWidget {
  final Map<String, dynamic>? childData;
  final Function createQuiz;
  const QuizReport(
      {Key? key, required this.createQuiz, required this.childData})
      : super(key: key);

  @override
  _QuizReportState createState() => _QuizReportState();
}

class _QuizReportState extends State<QuizReport> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference quizCollection =
      _firestore.collection(DBConstants.quizCollectionName);
  late List<_ChartData> data = [];
  late TooltipBehavior _tooltip;
  Map<String, List<String>> subjectQuizId = {};
  // List<String> subjectQuizId = [];
  Map<String, Map<String, List<String>>> subjectQuizData = {
    "Class 1": {},
    "Class 2": {},
    "Class 3": {},
    "Class 4": {},
    "Class 5": {},
    "Class 6": {},
    "Class 7": {},
    "Class 8": {},
    "Class 9": {},
    "Class 10": {},
  };
  Map<String, double> subScore = {
    'Maths': 0,
    'Computer': 0,
    'Environmental Studies': 0,
    'General Knowledge': 0,
    'English': 0,
    'Social Science': 0,
    'Science': 0,
  };
  bool _loading = true;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    getQuizId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_loading);
    data.forEach((value) => print(value.y));
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
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(20),
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
                        primaryXAxis:
                            CategoryAxis(labelAlignment: LabelAlignment.center),
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
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
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
    );
  }

  Future<void> getQuizId() async {
    subjectQuizData.forEach((grade, subjects) async {
      DocumentReference documentReference = quizCollection.doc(grade);
      DocumentSnapshot documentSnapshot = await documentReference.get();
      Map<String, dynamic> classData =
          documentSnapshot.data() as Map<String, dynamic>;
      classData.keys.forEach((sub) {
        List<String> subQuizIds = [];
        classData[sub].keys.forEach((topic) {
          classData[sub][topic].keys.forEach((difficulty) {
            classData[sub][topic][difficulty].forEach((quizId) {
              if (!subQuizIds.contains(quizId)) {
                subQuizIds.add(quizId);
              }
            });
          });
        });
        subjectQuizData[grade]?[sub] = subQuizIds;
        if (grade == 'Class 10') {
          updateScoreValue();
        }
      });
    });
  }

  void quizGraphData() {
    subScore.forEach((key, value) => data.add(_ChartData(key, value)));
    setState(() {
      _loading = false;
    });
  }

  void updateScoreValue() {
    widget.childData?[ChildDataConstants.quizes].forEach((quiz) {
      subjectQuizData.keys.forEach((grade) {
        subjectQuizData[grade]!.keys.forEach((subject) {
          print(subject);
          if (subjectQuizData[grade]![subject]!
              .contains(quiz[ChildDataConstants.quizId])) {
            print(
                "Quiz Score for Quiz ID ${quiz[ChildDataConstants.quizId]} is = ${quiz[ChildDataConstants.scores]}");
            quiz[ChildDataConstants.scores].forEach((score) {
              subScore[subject] = subScore[subject]! + score;
            });
          }
          // double sum = 0;

          // subScore[subject] = sum + subScore[subject]!;
          // return subjectQuizData[grade]?[subject]!
          //     .contains(quiz[ChildDataConstants.quizId]);
        });
      });
    });
    quizGraphData();
  }
}
