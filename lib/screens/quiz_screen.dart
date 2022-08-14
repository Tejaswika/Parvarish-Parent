import "package:flutter/material.dart";
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:parent/constants/db_constants.dart';
// import '../constants/db_constants.dart';
// import '../data/quiz_display_data.dart';
// import '../data/quiz_searching_data.dart';

import './quiz_report_screen.dart';

class QuizScreen extends StatefulWidget {
  final Function createQuiz;
  const QuizScreen({Key? key, required this.createQuiz}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class _QuizScreenState extends State<QuizScreen> {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // late final CollectionReference _quizCollection =
  //     _firestore.collection(DBConstants.quizCollectionName);

  // List<String> classNames = [];
  // late List allData;

  // // lateList<String> duplicate;

  // QuizSearchData obj = QuizSearchData();

  // void storeForSearch() {
  //   QuizSearchData(classNames.map((v) => v).toList());
  //   print(classNames);
  //   print(QuizSearchData().grade);
  // }

  // void beautifyData() {
  //   for (int i = 0; i < QuizSearchData().grade.length; i++) {
  //     QuizDisplayData().grade.add(QuizSearchData()
  //         .grade[i]
  //         .replaceAll(RegExp('[\\W_]+'), '')
  //         .toLowerCase());
  //     QuizDisplayData().grade[i].toTitleCase();
  //   }
  // }

  // void getClassNames() async {
  //   QuerySnapshot querySnapshot = await _quizCollection.get();
  //   // classNames = querySnapshot.docs.toList<String>();
  //   allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   for (var doc in querySnapshot.docs) {
  //     classNames.add(doc.id);
  //   }
  //   print("#####################");
  //   print(classNames);
  //   print(allData);
  //   storeForSearch();
  //   beautifyData();

  //   // final getdocs(_quizCollection);
  //   print(_firestore.collection(DBConstants.quizCollectionName).id);
  //   print("#####################");
  // }

  @override
  void initState() {
    // getClassNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const QuizReport(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => widget.createQuiz(context),
      ),
    );
  }
}
