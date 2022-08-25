import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parent/constants/db_constants.dart';

import 'package:parent/widgets/quiz_options.dart';
import '../services/snackbar_service.dart';

class QuizForm extends StatefulWidget {
  final Map<String, dynamic>? childData;
  final String? childId;
  const QuizForm({Key? key, required this.childData, required this.childId})
      : super(key: key);

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  List<DropdownMenuItem<String>> grade = [];
  List<DropdownMenuItem<String>> subject = [];
  List<DropdownMenuItem<String>> topic = [];
  List<DropdownMenuItem<String>> difficulty = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _quizCollection =
      _firestore.collection(DBConstants.quizCollectionName);
  Map<String, dynamic> classData = {};
  Map<String, dynamic> subjectData = {};
  Map<String, dynamic> topicData = {};
  List<dynamic> diffData = [];
  Map<String, dynamic> classList = {
    "Class 1": "Class 1",
    "Class 2": "Class 2",
    "Class 3": "Class 3",
    "Class 4": "Class 4",
    "Class 5": "Class 5",
    "Class 6": "Class 6",
    "Class 7": "Class 7",
    "Class 8": "Class 8",
    "Class 9": "Class 9",
    "Class 10": "Class 10",
  };
  List<DropdownMenuItem<String>> getClassDropdownList() {
    List<DropdownMenuItem<String>> classes = [];
    for (var grade in classList.keys) {
      classes.add(DropdownMenuItem(child: Text(grade), value: grade));
    }
    // print(classes);
    return classes;
  }

  List<DropdownMenuItem<String>> getSubjectDropDownList() {
    List<DropdownMenuItem<String>> subjects = [];
    for (var subject in classData.keys) {
      subjects.add(DropdownMenuItem(child: Text(subject), value: subject));
    }
    // print(subjects);
    return subjects;
  }

  List<DropdownMenuItem<String>> getTopicDropDownList() {
    List<DropdownMenuItem<String>> topics = [];
    for (var topic in subjectData.keys) {
      topics.add(DropdownMenuItem(
        child: Text(topic),
        value: topic,
      ));
    }
    // print(topics);
    return topics;
  }

  List<DropdownMenuItem<String>> getDiffDropDownList() {
    List<DropdownMenuItem<String>> diff = [];
    for (var difficulty in topicData.keys) {
      diff.add(DropdownMenuItem(
        child: Text(difficulty),
        value: difficulty,
      ));
    }
    // print(diff);
    return diff;
  }

  String? selectedClass = "Class 1";
  String? selectedSub;
  String? selectedTopic;
  String? selectedDiff;
  final _formKey = GlobalKey<FormState>();
  void _showQuizOptions(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: ((context) => QuizOptions(
          topicName: selectedTopic,
          quizOption: diffData,
         // childData: widget.childData,
          diffLevel: selectedDiff,
          childId: widget.childId)),
    );
  }

  @override
  void initState() {
    selectedClass = "Class " + widget.childData?[ChildDataConstants.grade];
    if (selectedClass != null) {
      _getClassData(selectedClass!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(classData);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null) {
                return "Please select a value";
              }
              return null;
            },
            iconSize: 30,
            hint: const Text("Select class"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            elevation: 10,
            items: getClassDropdownList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                _getClassData(newValue);
              }
            },
            value: selectedClass,
          ),
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null) {
                return "Please select a value";
              }
              return null;
            },
            iconSize: 30,
            hint: const Text("Select subject"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            elevation: 10,
            items: classData.isNotEmpty ? getSubjectDropDownList() : [],
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedSub = newValue;
                });
                _getSubjectData(newValue);
              }
            },
            value: selectedSub,
          ),
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null) {
                return "Please select a value";
              }
              return null;
            },
            iconSize: 30,
            hint: const Text("Select topics"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            elevation: 10,
            items: subjectData.isNotEmpty ? getTopicDropDownList() : [],
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedTopic = newValue;
                });
                _getTopicData(newValue);
              }
            },
            value: selectedTopic,
          ),
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null) {
                return "Please select a value";
              }
              return null;
            },
            iconSize: 30,
            hint: const Text("Select difiiculty"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            elevation: 10,
            items: subjectData.isNotEmpty ? getDiffDropDownList() : [],
            onChanged: (String? newValue) {
              if (newValue != null) {
                _getDiffData(newValue);
                setState(() {
                  selectedDiff = newValue;
                });
              }
            },
            value: selectedDiff,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SnackbarService.showInfoSnackbar(context,
                        "Thers are ${diffData.length} available quizes!");
                    _showQuizOptions(context);
                  }
                },
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Show Quizes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _getClassData(String grade) async {
    DocumentReference documentReferencer =
        _quizCollection.doc(classList[grade]);
    await documentReferencer.get().then((DocumentSnapshot quizDataSnapshot) {
      Map<String, dynamic>? data =
          quizDataSnapshot.data() as Map<String, dynamic>;
      setState(() {
        selectedClass = grade;
        classData = data;
      });
      // print(data);
    });
  }

  void _getSubjectData(String subject) {
    setState(() {
      subjectData = classData[subject];
    });
  }

  void _getTopicData(String topic) {
    setState(() {
      topicData = subjectData[topic];
    });
  }

  void _getDiffData(String difficulty) {
    setState(() {
      diffData = topicData[difficulty];
    });
  }
}
